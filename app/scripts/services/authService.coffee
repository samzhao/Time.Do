'use strict'

angular.module('timedoApp')
  .factory 'authService', ($firebase, $firebaseSimpleLogin, $state) ->
    dataRef = new Firebase("https://burning-fire-6153.firebaseio.com/")
    loginObj = $firebaseSimpleLogin(dataRef);

    returnObj = {}
    returnObj.register = (email, password) ->
      loginObj.$createUser(email, password, true).then ((user) ->
        returnObj.login('password', {email: email, password: password})
        $state.go("index")
      ), (error) ->
        console.log "Registration failed: ", error
        alert "Registration failed: #{error.message}"
    returnObj.isLoggedIn = () ->
      # loginObj.user isnt null
      return true
    returnObj.socialLogin = (provider) ->
      loginObj.$login(provider).then ((user) ->
        $state.go("index")
        console.log "#{provider} Logged in as: ", user.uid
      ), (error) ->
        console.error "#{provider} Login failed: ", error
        alert "#{provider} login failed: #{error.message}"
    returnObj.login = (provider, credentials) ->
      loginObj.$login(provider, credentials).then ((user) ->
        $state.go("index")
        console.log "Logged in as: ", user.uid
      ), (error) ->
        console.error "Login failed: ", error
        alert "Login failed: #{error.message}"
    returnObj.logout = () ->
      console.log "Logging out"
      loginObj.$logout()
    returnObj