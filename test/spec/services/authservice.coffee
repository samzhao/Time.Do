'use strict'

describe 'Service: Authservice', () ->

  # load the service's module
  beforeEach module 'timedoApp'

  # instantiate service
  Authservice = {}
  beforeEach inject (_Authservice_) ->
    Authservice = _Authservice_

  it 'should do something', () ->
    expect(!!Authservice).toBe true
