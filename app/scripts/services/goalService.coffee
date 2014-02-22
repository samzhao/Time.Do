'use strict'

angular.module('timedoApp')
  .factory 'goalService', ($firebase) ->

    goalsRef = new Firebase("https://timedo.firebaseio.com/goals")
    goals = $firebase(goalsRef)

    # Public API here
    {
      getGoals: () ->
        goals
      saveGoal: (index) ->
        goals.$save(index)
    }