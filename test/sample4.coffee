should = require('chai').should()
Emailplate = require '..'

describe "handlebars test", ->

  before ->
    @emailplate = new Emailplate
      views: __dirname + '/fixtures'

  it 'should register a helper', (done) ->
    @emailplate.render 'sample4', 
      name: 'kinua'
      helpers: 
        dear: (name) ->
          "dear #{name}"
    , 
      (err, html) ->
        html.should.match /dear kinua/
        done()

  it 'should render inline css html', (done) ->
    @emailplate.render 'sample4', (err, html) ->
      html.should.be.a 'string'
      done()

  it 'should register some stylusSetting', (done) ->
    @emailplate.render 'sample4', 
      name: 'kinua'
      stylus:
        imageColor1: 'green'  
        imageColor2: 'white' 
    , 
      (err, html) ->
        html.should.match /dear kinua/
        done()


