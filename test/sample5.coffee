should = require('chai').should()
Emailplate = require '..'

describe "handlebars partial test", ->

  before ->
    @emailplate = new Emailplate
      views: __dirname + '/fixtures'

  it 'should have h2 tag', (done) ->
    @emailplate.render 'sample5', (err, html) ->
      html.should.match /h2 style/
      done()
