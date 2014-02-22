'use strict'

describe 'Service: Goalservice', () ->

  # load the service's module
  beforeEach module 'timedoApp'

  # instantiate service
  Goalservice = {}
  beforeEach inject (_Goalservice_) ->
    Goalservice = _Goalservice_

  it 'should do something', () ->
    expect(!!Goalservice).toBe true
