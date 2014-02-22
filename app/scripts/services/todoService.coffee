'use strict'

angular.module('timedoApp')
  .factory 'todoService', ($firebase) ->

    todosRef = new Firebase("https://timedo.firebaseio.com/todos")
    todos = $firebase(todosRef)

    # Public API here
    {
      getTodos: () ->
        todos
      saveTodo: (index) ->
        todos.$save(index)
    }