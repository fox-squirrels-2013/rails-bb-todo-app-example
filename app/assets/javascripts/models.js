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
    var _this = this
    this.todos.url = function() { return _this.url() + '/todos' }
    this.on('sync', function(){ _this.todos.fetch() })
  }

  p.url = function(){
    if (this.isNew()) return '/api/lists'
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
