'use strict'

describe 'Service: Todoservice', () ->

  # load the service's module
  beforeEach module 'timedoApp'

  # instantiate service
  Todoservice = {}
  beforeEach inject (_Todoservice_) ->
    Todoservice = _Todoservice_

  it 'should do something', () ->
    expect(!!Todoservice).toBe true
