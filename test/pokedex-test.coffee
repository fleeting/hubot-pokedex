chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'pokedex', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/pokedex')(@robot)

  it 'registers a hear listener', ->
    expect(@robot.hear).to.have.been.calledWith(/^pokemon ?$/im)

  it 'registers a hear listener', ->
    expect(@robot.hear).to.have.been.calledWith(/pokedex (.*) (.*)/i)

  it 'registers a hear listener', ->
    expect(@robot.hear).to.have.been.calledWith(/^pokedex help ?$/im)
