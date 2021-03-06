'use strict'

describe 'Directive: goalItem', () ->

  # load the directive's module
  beforeEach module 'timedoApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<goal-item></goal-item>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the goalItem directive'
