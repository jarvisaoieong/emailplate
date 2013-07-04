module.exports = 
  name: 'sample3'
  template:
    engine: 'handlebars'
    file: 'html.hbs'
  style:
    engine: 'stylus'
    file: 'style.styl'
  locals:
    name: 'jarvis'
    helpers: 
      dear: (name) ->
        "dear #{name}."
