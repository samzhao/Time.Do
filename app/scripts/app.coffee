'use strict'

app = angular.module('timedoApp', [
  'ngCookies'
  'ngSanitize'
  'ngAnimate'
  'ui.router'
  'firebase'
])

app.config(($stateProvider, $urlRouterProvider, $locationProvider) ->
  $locationProvider.html5Mode(false)
  $urlRouterProvider.otherwise("/")
  $stateProvider
    .state 'index',
      url: "/"
      templateUrl: 'views/main.html'
    .state 'login',
      url: '/login'
      templateUrl: 'views/login.html'
      controller: "LoginCtrl"
).run ($rootScope, $state, $stateParams, authService) ->
  $rootScope.$watch ->
    authService.isLoggedIn()
  , (newValue, oldValue) ->
    if newValue is false
      $state.go('login')
    else
      console.debug('Authenticated.')
      $state.go('index')
  $rootScope.$on '$stateChangeStart', (event, toState, fromState) ->
    unless authService.isLoggedIn()
      unless toState.name is "login"
        console.debug('Authenticating...');
        $rootScope.$broadcast('$stateChangeError');
        event.preventDefault();
        $state.go('login');