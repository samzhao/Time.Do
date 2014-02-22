'use strict'

angular.module('timedoApp')
  .controller 'LoginCtrl', ($scope, authService) ->
    $scope.newLogin = {}
    $scope.newRegister = {}
    opts = {
      rememberMe: true
    }
    $scope.login = (provider) ->
      newLogin = $.extend({}, $scope.newLogin, opts)
      if provider is "password"
        authService.login(provider, newLogin)
      else
        authService.socialLogin(provider)
    $scope.register = () ->
      email = $scope.newRegister.email
      password = $scope.newRegister.password
      authService.register(email, password)
