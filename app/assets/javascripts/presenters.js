//= require templates

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

  p.id = function(){
    return this.listModel.get('id')
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

  p.notCompleted = function(){
    return this.todoModel.get('status') !== 'complete'
  }

  p.render = function(){
    return templates.todoItem(this)
  }


}.call(this)
