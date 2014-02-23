'use strict'

angular.module('timedoApp')
  .directive('todoItem', ($timeout, todoService) ->
    templateUrl: 'views/partials/todo-item.html'
    restrict: 'E'
    controller: ($scope, $element, $attrs) ->
      timeInMs = $scope.todo.elapsedTime * 1000
      $scope.elapsedTime = $scope.todo.elapsedTime
      $scope.totalTime = $scope.todo.totalTime
      counter = null

      todoIndex = $scope.todo.$id
      realTodo = $scope.todos[todoIndex]
      todo = $scope.todo

      $scope.counting = false
      countUp = () ->
        timeInMs+= 1000;
        $scope.elapsedTime = moment(timeInMs).seconds()
        todo.elapsedTime = $scope.elapsedTime
        # todoService.saveTodo(todoIndex)

        $scope.$emit("timer-ticking", {todoIndex: todoIndex})
        counter = $timeout(countUp, 1000)

      $scope.start = () ->
        unless $scope.counting
          counter = $timeout(countUp, 1000)
          $scope.counting = true
          todo.timerRunning = true
          todo.state = "Started"
          todo.status = "In Progress"
          $scope.$emit("timer-started", {todoIndex: todoIndex})
      $scope.pause = () ->
        if $scope.counting
          $timeout.cancel(counter)
          $scope.counting = false
          todo.timerRunning = false
          todo.state = "Paused"
          $scope.$emit("timer-stopped", {todoIndex: todoIndex})
      $scope.stop = () ->
        timeInMs = 0;
        todo.elapsedTime = moment(timeInMs).seconds()
        $timeout.cancel(counter)
        $scope.counting = false
        todo.timerRunning = false
        todo.state = "Stopped"
        $scope.$emit("timer-stopped", {todoIndex: todoIndex})

      $scope.progressClass = "progress-bar-info"
      # $scope.timerCtrlText = "Start"
      $scope.$watch ->
        todo.state
      , (newValue, oldValue) ->
        switch newValue
          when "Paused"
            $scope.progressClass = "progress-bar-danger"
          when "Stopped"
            if todo.elapsedTime is 0
              $scope.progressClass = "progress-bar-warning"
            else
              $scope.progressClass = "progress-bar-danger"
          else
            $scope.progressClass = "progress-bar-info"
      # $scope.$watch ->
      #   todo.timerRunning
      # , (newValue, oldValue) ->
      #   if newValue
      #     $scope.timerCtrlText = "Pause"
      #   else
      #     $scope.timerCtrlText = "Start"
      $scope.ctrlTimer = () ->
        switch $scope.counting
          when true
            $scope.pause()
          else
            $scope.start()

      $scope.$on "timer-started", (event, data) ->
        todo = $scope.todos[data.todoIndex]
        todo.elapsedTime = $scope.elapsedTime
        todoService.saveTodo(todoIndex)

      $scope.$on "timer-stopped", (event, data) ->
        todo = $scope.todos[data.todoIndex]
        todo.elapsedTime = $scope.elapsedTime
        todoService.saveTodo(todoIndex)

      $scope.$on "timer-ticking", (event, data) ->
        if $scope.elapsedTime >= $scope.totalTime
          todo.status = "Completed"
        todo.elapsedTime = $scope.elapsedTime
        todoService.saveTodo(data.todoIndex)

      $scope.todos.$on "child_removed", (snapShot) ->
        $scope.counting = false
        $timeout.cancel(counter)

      # $scope.$watch ->
      #   todo.state
      # , (newValue, oldValue) ->
      #   if newValue is "Paused"
      #     $scope.pause()
      #   if newValue is "Started"
      #     $scope.start()

      if todo.state is "Started"
        $scope.start()
      if todo.state is "Paused"
        $scope.pause()
      if todo.state is "Stopped"
        $scope.stop()

      # window.onbeforeunload = (event) ->
      #   todo.elapsedTime = $scope.elapsedTime
      #   todoService.saveTodo(todoIndex)
      #   # message = 'Sure you want to leave?'
      #   # if (typeof event == 'undefined')
      #   #   event = window.event
      #   # if (event)
      #   #   event.returnValue = message
      #   # return message
      #   return
  )
