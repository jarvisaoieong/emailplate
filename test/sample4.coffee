should = require('chai').should()
Emailplate = require '..'

describe "multiple style file test", ->

  before ->
    @emailplate = new Emailplate
      views: __dirname + '/fixtures'

  it 'should have style in h1', (done) ->
    @emailplate.render 'sample4',
      (err, html) ->
        html.should.match /h1 style/
        done()

  it 'should have style in h2', (done) ->
    @emailplate.render 'sample4',
      (err, html) ->
        html.should.match /h2 style/
        done()

