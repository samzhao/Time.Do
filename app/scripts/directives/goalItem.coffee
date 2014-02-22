'use strict'

angular.module('timedoApp')
  .directive('goalItem', (goalService) ->
    templateUrl: 'views/partials/goal-item.html'
    restrict: 'E'
    controller: ($scope, $element, $attrs) ->
  )
