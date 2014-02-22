'use strict'

angular.module('timedoApp')
  .factory 'goalService', ($firebase) ->
    # Service logic
    # ...

    goalsRef = new Firebase("https://burning-fire-6153.firebaseio.com/goals")
    goals = $firebase(goalsRef)

    # Public API here
    {
      getGoals: () ->
        goals
      saveGoal: (index) ->
        goals.$save(index)
    }