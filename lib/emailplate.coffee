_ = require 'underscore'
glob = require 'glob'
async = require 'async'
fs = require 'fs'
cons = require 'consolidate'
stylus = require 'stylus'
juice = require 'juice'

module.exports = class Emailplate

  defaults:
    views: './emailplates'

  constructor: (@options = {}) ->
    @options = _.defaults @options, @defaults

  get: (name) ->
    @options[name]

  set: (option, val) ->
    if arguments.length is 1
      _.extend @options, option
    else
      @options[option] = val
    this

  #
  # Get themes info in template folder with callback `fn(err, info)`
  #
  # @param {Function} fn
  #

  themes: (fn) ->
    glob "#{@options.views}/**/emailplate.json", (err, files) ->
      parallel = []
      _.each files, (file) ->
        parallel.push (cb) ->
          fs.readFile file, 'utf-8', (err, content) ->
            info = JSON.parse content
            cb null, info
      async.parallel parallel, fn

  #
  # Get Single theme info by a theme name
  #
  # @param {String} name
  # @param {Function} fn
  #

  theme: (name, fn) ->
    fs.readFile "#{@options.views}/#{name}/emailplate.json", 'utf-8', (err, content) ->
      return fn err if err
      info = JSON.parse content
      fn null, info

  #
  # Render the inline css html with the `theme`, `data` and callback `fn(err, html)`
  #
  # @param {String} theme
  # @param {Object|Function} data
  # @param {Function} fn
  # @api public
  #
  
  render: (theme, data, fn) ->
    if _.isFunction data
      fn = data
      data = {}
    themeDir = "#{@options.views}/#{theme}"
    fs.readFile "#{themeDir}/emailplate.json", 'utf-8', (err, content) ->
      info = JSON.parse content
      data = _.defaults data, info.locals
      async.parallel
        html: (cb) ->
          cons[info.template.engine] "#{themeDir}/#{info.template.file}", data, cb
        css: (cb) ->
          fs.readFile "#{themeDir}/#{info.style.file}", 'utf-8', (err, content) ->
            stylus.render content, cb
      ,
        (err, results) ->
          html = juice results.html, results.css
          fn null, html
