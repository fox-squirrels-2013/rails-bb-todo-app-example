//= require underscore
//= require jquery
//= require backbone

//= require templates

// ListCollection
// job: get list data from server
// depends: templates
!function(){

  var modl = this.TodoModel = Backbone.Model.extend()
    , p = modl.prototype

}.call(this)

!function(){

  var modl = this.ListModel = Backbone.Model.extend()
    , p = modl.prototype

  p.initialize = function(){
    this.todos = new TodoCollection
    this.todos.url = this.url() + '/todos'
    this.todos.fetch()
    // this.on('sync', function(){
    //   console.log("THIS MIGHT NOT BE CALLED")
    //   this.todos.fetch()
    // }, this)
  }

  p.url = function(){
    console.log(this.get('id'))
    if (this.get('id')){
      return '/api/lists/' + this.get('id')
    }
    else {
      return '/api/lists'
    }
  }


}.call(this)

!function(){

  var coll = this.ListCollection = Backbone.Collection.extend()
    , p = coll.prototype


  p.url = '/api/lists'

  p.model = ListModel


}.call(this)

!function(){

  var coll = this.TodoCollection = Backbone.Collection.extend()
    , p = coll.prototype

  p.model = TodoModel


}.call(this)


// UIController
// job: manage the primary ui
// depends: templates

!function(){

  var view = this.UIViewController = Backbone.View.extend()
    , p = view.prototype

  p.events = {
    "submit .list-creator": "createList"
  }

  p.initialize = function(){
    this.listCollection = new ListCollection
    this.listCollection.on('error', this.error, this)
    this.listCollection.on('sync', this.render, this)
    var _this = this
    this.listCollection.once('sync', function(collection){
      collection.each(function(list){
        list.todos.fetch()
        list.todos.once('sync', _this.render, _this)
      })
    }, this)
    this.listCollection.fetch()
  }

  p.createList = function(event){
    event.preventDefault()
    var listName = $(event.target).serializeArray()[0].value

    var listModel = this.listCollection.create({name: listName})
  }

  p.render = function(){
    var uiPresenter = new UIPresenter({listCollection: this.listCollection})
    this.$el.html(uiPresenter.render())
    return this
  }

  p.error = function(){
    console.log("This did not work.")
  }

}.call(this)

// UIPresenter

!function(){

  var klass = this.UIPresenter = function(args){
    this.listCollection = args.listCollection
  }

  var p = klass.prototype

  p.render = function(){
    return templates.ui(this)
  }

  p.lists = function(){
    return this.listCollection.map(function(listModel){
      return new ListPresenter(listModel).render()
    })
  }

  p.createListEndpoint = '/api/lists'

}.call(this)

!function(){

  var klass = this.ListPresenter = function(listModel){
    this.listModel = listModel
  }

  var p = klass.prototype

  p.render = function(){
    return templates.todoList(this)
  }

  p.name = function(){
    return this.listModel.get('name')
  }

  p.renderTodoItems = function(status){
    return new TodoItemsPresenter(this.listModel.todos.where({'status': status})).render()
  }

  p.completedTodoItems = function(){
    return this.renderTodoItems('complete')
  }

  p.wipTodoItems = function(){
    return this.renderTodoItems('in_progress')
  }

  p.incompleteTodoItems = function(){
    return this.renderTodoItems('incomplete')
  }


  //   def completedTodoItems
  //     render_todo_items('complete')
  //   end

  //   def wipTodoItems
  //     render_todo_items('in_progress')
  //   end

  //   def incompleteTodoItems
  //     render_todo_items('incomplete')
  //   end

  //   def render_todo_items(status)
  //     TodoItemsPresenter.new(@list.todos.where(:status => status).all).render
  //   end

}.call(this)

!function(){

  var klass = this.TodoItemsPresenter = function(todoCollection){
    this.todoCollection = todoCollection
  }
  var p = klass.prototype

  p.items = function(){
    return this.todoCollection.map(function(item){
      return new TodoItemPresenter(item).render()
    })
  }

  p.render = function(){
    return templates.todoItemList(this)
  }

    // def items
    //   @items.map do |todo_item|
    //     TodoItemPresenter.new(todo_item).render
    //   end
    // end

    // def template_name
    //   'todoItemList'
    // end


}.call(this)

!function(){

  var klass = this.TodoItemPresenter = function(todoModel){
    this.todoModel = todoModel
  }

  var p = klass.prototype

  p.title = function(){
    return this.todoModel.get('title')
  }

  p.id = function(){
    return this.todoModel.get('id')
  }

  p.render = function(){
    return templates.todoItem(this)
  }


}.call(this)



   //  def title
   //    @item.title
   //  end

   //  def id
   //    @item.id
   //  end

   //  def template_name
   //    'todoItem'
   //  end
// Driver code

$(function() {

  templates.load()

  // make ListCollection
  // tell it the url for lists
  // pass it to controller
  window.uiController = new UIViewController({el: $('.main')}).render()

  $('body').removeClass('loading')

})
