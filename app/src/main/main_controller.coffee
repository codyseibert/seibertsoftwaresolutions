module.exports = [
  '$scope'
  'lodash'
  '$http'
  (
    $scope
    _
    $http
  ) ->

    $scope.form = {}
    $scope.success = null

    $scope.submit = ->
      $http.post 'mailer', $scope.form
        .then (result) ->
          $scope.success = true
          $scope.form = {}
        .catch (err) ->
          $scope.success = false
          $scope.form = {}

    return this
]
