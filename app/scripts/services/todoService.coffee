'use strict'

angular.module('timedoApp')
  .factory 'todoService', ($firebase, remoteUrl) ->

    todosRef = new Firebase("#{remoteUrl}/todos")
    todos = $firebase(todosRef)

    # Public API here
    {
      getTodos: () ->
        todos
      saveTodo: (index) ->
        todos.$save(index)
    }