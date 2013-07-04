should = require('chai').should()
Emailplate = require '..'

describe "handlebars test", ->

  before ->
    @emailplate = new Emailplate
      views: __dirname + '/fixtures'

  it 'should register a helper', (done) ->
    @emailplate.render 'sample2', 
      name: 'kinua'
      helpers: 
        dear: (name) ->
          "dear #{name}"
    , 
      (err, html) ->
        html.should.match /dear kinua/
        done()

  it 'should render inline css html', (done) ->
    @emailplate.render 'sample2', (err, html) ->
      html.should.be.a 'string'
      html.should.match /h1 style/
      done()


