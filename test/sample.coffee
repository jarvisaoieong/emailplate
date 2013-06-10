should = require('chai').should()
Emailplate = require '..'

describe "jade test", ->

  beforeEach ->
    @emailplate = new Emailplate
      views: __dirname + '/fixtures'

  it 'shoud set custom template folder', ->
    @emailplate.set 'views', './templates'
    @emailplate.get('views').should.equal './templates'
    @emailplate.set
      'views': './another_templates'
    @emailplate.get('views').should.equal './another_templates'

  it 'should get the themes info', (done) ->
    @emailplate.themes (err, themes) ->
      themes.should.be.an 'array'
      themes[0].name.should.equal 'sample'
      done()

  it 'should get a theme info', (done) ->
    @emailplate.theme 'sample', (err, theme) ->
      theme.should.be.a 'object'
      theme.name.should.equal 'sample'
      done()

  it 'should render inline css html', (done) ->
    @emailplate.render 'sample', (err, html) ->
      html.should.be.a 'string'
      html.should.match /h1 style/
      done()


