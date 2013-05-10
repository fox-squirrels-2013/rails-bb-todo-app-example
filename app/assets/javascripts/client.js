//= require underscore
//= require jquery
//= require backbone

//= require templates
//= require models
//= require presenters

// UIController
// job: manage the primary ui
// depends: templates

!function(){

  var view = this.UIViewController = Backbone.View.extend()
    , p = view.prototype

  p.events = {
    "submit .list-creator": "createList"
  , "click  [data-list] > .delete": "deleteList"
  , "click  [data-todo] > .complete": "completeTodo"
  }

  p.initialize = function(){
    this.listCollection = new ListCollection
    this.listCollection.on('error', this.error, this)
    this.listCollection.on('change destroy', this.render, this)

    // the first time the lists sync, also sync all their
    // todos
    var _this = this
    this.listCollection.once('sync', function(collection){
      _this.hideLoader()

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

    this.listCollection.create({name: listName})
  }

  p.deleteList = function(event){
    var listId = $(event.target).closest('[data-list]').data('id')
    this.listCollection.get(listId).destroy()
  }

  p.completeTodo = function(event){
    var listId = $(event.target).closest('[data-list]').data('id')
    var todoId = $(event.target).closest('[data-todo]').data('id')

    this.listCollection.get(listId).todos.get(todoId).
      save({ status: 'complete' })
  }

  p.render = function(){
    var uiPresenter = new UIPresenter({listCollection: this.listCollection})
    this.$el.html(uiPresenter.render())
    return this
  }

  // the loader should probably be local to this element - i.e. #main should
  // have a loader, not the body tag
  p.hideLoader = function(){
    $('body').removeClass('loading')
  }

  p.error = function(){
    console.error("This did not work.")
  }

}.call(this)


// Driver code
// Job: start the application

$(function() {

  templates.load()

  var uiController = new UIViewController({el: $('.main')}).render()

  // for development
  window.uiController = uiController

})
