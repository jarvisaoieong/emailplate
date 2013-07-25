fs = require 'fs'

module.exports = 
  name: 'sample5'
  template:
    engine: 'handlebars'
    file: 'html.hbs'
  style:
    engine: 'stylus'
    file: 'style.styl'
  locals:
    partials:
      part: fs.readFileSync(__dirname + '/part.hbs', 'utf-8')
