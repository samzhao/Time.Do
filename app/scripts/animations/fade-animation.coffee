'use strict'

angular.module('timedoApp')
  .animation '.fade-animation', ->
    enter: (element, done) ->
      $(element).css 'display', "none"
      $(element).fadeIn(300, done())
    leave: (element, done) ->
      $(element).fadeOut(300, done())