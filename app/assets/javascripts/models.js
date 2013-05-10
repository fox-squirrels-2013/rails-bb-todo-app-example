//= require backbone

// Models

// TodoModel
!function(){

  var modl = this.TodoModel = Backbone.Model.extend()
    , p = modl.prototype

}.call(this)

// ListModel
!function(){

  var modl = this.ListModel = Backbone.Model.extend()
    , p = modl.prototype

  p.initialize = function(){
    this.todos = new TodoCollection
    this.todos.url = this.url() + '/todos'
    this.todos.fetch()
  }

  // p.url = '/todo'

  p.url = function(){
    if (this.isNew()) return '/api/lists';
    return '/api/lists/' + this.get('id')
  }


}.call(this)

// ---

// Collections

// ListCollection
// job: get list data from server
// depends: templates
!function(){

  var coll = this.ListCollection = Backbone.Collection.extend()
    , p = coll.prototype


  p.url = '/api/lists'

  p.model = ListModel


}.call(this)

// TodosCollection
!function(){

  var coll = this.TodoCollection = Backbone.Collection.extend()
    , p = coll.prototype

  p.model = TodoModel


}.call(this)
