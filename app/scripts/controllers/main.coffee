'use strict'

angular.module('timedoApp')
  .controller 'MainCtrl', ($scope, todoService, goalService, authService, $compile, $element, $timeout, $state) ->

    $scope.logout = ->
      # authService.logout()

    $scope.todos = todoService.getTodos()
    $scope.goals = goalService.getGoals()
    $scope.todoList = []
    $scope.todos.$on "loaded", (data) ->
      for key of data
        $scope.todoList.push data[key]
    $scope.newTodo = {}
    $scope.newGoal = {}

    $scope.addTodo = ->
      additionalParams = {
        timerRunning: false,
        totalTime: parseInt($scope.newTodo.totalTime, 10) || 0,
        elapsedTime: 0,
        state: "Stopped",
        status: 'New',
        $priority: $scope.todos.$getIndex().length+1
      }
      props = $.extend({}, $scope.newTodo, additionalParams)
      $scope.todos.$add(props)
      $scope.newTodo = {}

    $scope.addGoal = ->
      $scope.goals.$add($scope.newGoal)
      $scope.newGoal = {}

    $scope.initTodo = ->

    # $scope.timerRunning = false

    # $scope.ctrlTimer = (index) ->
    #   # $scope.$broadcast('timer-start')
    #   indexes = $scope.todos.$getIndex()
    #   todoIndex = indexes[index]
    #   todo = $scope.todos[todoIndex]
    #   if todo.timerRunning
    #     $('timer')[index].stop()
    #     todo.timerRunning = false
    #     $scope.todos.$save(todoIndex)
    #   else
    #     $('timer')[index].start()
    #     todo.timerRunning = true
    #     $scope.todos.$save(todoIndex)

    # $scope.stopTimer = () ->
    #   $scope.$broadcast('timer-stop')
    #   $scope.timerRunning = false

    # $scope.$on 'timer-stopped', (event, data) ->
    #   # debugger
    #   console.log(data)

    # $scope.$on 'timer-tick', (event, data) ->

    $scope.gaugeOpts = {
      lines: 12,
      angle: 0.5,
      lineWidth: 0.1,
      limitMax: 'true',

      colorStart: "#6F6EA0",
      colorStop: "#C0C0DB",
      strokeColor: "#EEEEEE",
      generateGradient: true
    }

    $scope.sortableOptions = {
      update: (e, ui) ->
        console.log "update"
      stop: (e, ui) ->
        # this callback has the changed model
        console.log "stop"
    }

    getElapsedTime = (input) ->
      # Set the unit values in milliseconds.
      msecPerMinute = 1000 * 60
      msecPerHour = msecPerMinute * 60
      msecPerDay = msecPerHour * 24

      # Set a date and get the milliseconds
      date = new Date()
      dateMsec = date.getTime()
      fromNow = Date.create("#{input} from now")

      # Set the date to January 1, at midnight, of the specified year.
      # date.setMonth(0)
      # date.setDate(1)
      # date.setHours(0, 0, 0, 0)

      # Get the difference in milliseconds.
      interval = fromNow.getTime() - dateMsec

      # Calculate how many days the interval contains. Subtract that
      # many days from the interval to determine the remainder.
      days = Math.floor(interval / msecPerDay )
      interval = interval - (days * msecPerDay )

      # Calculate the hours, minutes, and seconds.
      hours = Math.floor(interval / msecPerHour )
      interval = interval - (hours * msecPerHour )

      minutes = Math.floor(interval / msecPerMinute )
      interval = interval - (minutes * msecPerMinute )

      seconds = Math.floor(interval / 1000 )

      # Display the result.
      document.write(days + " days, " + hours + " hours, " + minutes + " minutes, " + seconds + " seconds.")
