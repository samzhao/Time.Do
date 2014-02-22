'use strict'

angular.module('timedoApp')
  .factory 'todoService', ($firebase) ->
    # Service logic
    # ...

    todosRef = new Firebase("https://burning-fire-6153.firebaseio.com/todos")
    todos = $firebase(todosRef)

    # Public API here
    {
      getTodos: () ->
        todos
      saveTodo: (index) ->
        todos.$save(index)
    }