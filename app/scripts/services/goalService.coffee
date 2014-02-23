'use strict'

angular.module('timedoApp')
  .factory 'goalService', ($firebase, remoteUrl) ->

    goalsRef = new Firebase("#{remoteUrl}/goals")
    goals = $firebase(goalsRef)

    # Public API here
    {
      getGoals: () ->
        goals
      saveGoal: (index) ->
        goals.$save(index)
    }