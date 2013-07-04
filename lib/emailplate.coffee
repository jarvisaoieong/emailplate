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
    glob "#{@options.views}/**/emailplate.*", (err, files) ->
      results = _.map files, (file) -> require file
      fn null, results

  #
  # Get Single theme info by a theme name
  #
  # @param {String} name
  # @param {Function} fn
  #

  theme: (name, fn) ->
    fn null, require "#{@options.views}/#{name}/emailplate"

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
    info = require "#{themeDir}/emailplate"
    data = _.defaults data, info.locals
    async.parallel
      html: (cb) ->
        cons[info.template.engine] "#{themeDir}/#{info.template.file}", data, cb
      css: (cb) ->
        fs.readFile "#{themeDir}/#{info.style.file}", 'utf-8', (err, content) ->
          stylusObj = stylus(content)
          if _.isObject data.stylus
            _.each data.stylus, (value, key) ->  
              stylusObj.define(key, value)
          stylusObj.render cb
    ,
      (err, results) ->
        html = juice results.html, results.css
        fn null, html
