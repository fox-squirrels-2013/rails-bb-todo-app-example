//= require jquery
//= require mustache

// Templates Module
// job: extract templates from dom

!function() {

  var templates = this.templates = {}

  templates.load = function(){
    var templateElements = $("[data-template]")
    templateElements.each(function() {
      var el = $(this)
        , name = el.data('name')
        , source = el.text()

      templates[name] = Mustache.compile(source)
    })
  }

}.call(this)
