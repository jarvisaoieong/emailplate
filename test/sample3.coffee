should = require('chai').should()
Emailplate = require '..'

describe "emailplate.coffee test", ->

  before ->
    @emailplate = new Emailplate
      views: __dirname + '/fixtures'

  it 'should render inline css html', (done) ->
    @emailplate.render 'sample3', (err, html) ->
      html.should.match /h1 style/
      done()

  it 'should render css html with the default helper', (done) ->
    @emailplate.render 'sample3', (err, html) ->
      html.should.match /dear jarvis/
      done()

  it 'should render css html with the custom helper', (done) ->
    @emailplate.render 'sample3', 
      helpers:
        dear: (text) -> "lovely #{text}"
    ,
      (err, html) ->
        html.should.match /lovely jarvis/
        done()