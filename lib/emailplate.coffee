_ = require 'underscore'
glob = require 'glob'
async = require 'async'
fs = require 'fs'
cons = require 'consolidate'
stylus = require 'stylus'
juice = require 'juice'

module.exports = class Emailplate

  settings:
    views: './emailplates'

  constructor: (settings = {}) ->
    _.extend @settings, settings

  get: (name) ->
    @settings[name]

  set: (setting, val) ->
    if arguments.length is 1
      _.extend @settings, setting
    else
      @settings[setting] = val
    this

  #
  # Get themes info in template folder with callback `fn(err, info)`
  #
  # @param {Function} fn
  #

  themes: (fn) ->
    glob "#{@settings.views}/**/emailplate.json", (err, files) ->
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
    fs.readFile "#{@settings.views}/#{name}/emailplate.json", 'utf-8', (err, content) ->
      return fn err if err
      info = JSON.parse content
      fn null, info

  #
  # Render the inline css html with the `theme`, `options` and callback `fn(err, html)`
  #
  # @param {String} theme
  # @param {Object|Function} options
  # @param {Function} fn
  # @api public
  #
  
  render: (theme, options, fn, count = '') ->
    if _.isFunction options
      fn = options
      options = {}
    themeDir = "#{@settings.views}/#{theme}"
    fs.readFile "#{themeDir}/emailplate.json", 'utf-8', (err, content) ->
      info = JSON.parse content
      options = _.defaults options, info.locals
      async.parallel
        html: (cb) ->
          cons[info.template.engine] "#{themeDir}/html.#{info.template.extension}", options, cb
        css: (cb) ->
          fs.readFile "#{themeDir}/style#{count}.styl", 'utf-8', (err, content) ->
            stylus.render content, cb
      ,
        (err, results) ->
          html = juice results.html, results.css
          fn null, html

