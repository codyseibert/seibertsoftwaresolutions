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

    $scope.submit = ->
      $http.post 'mailer', $scope.form
        .then (result) ->
          console.log result
        .catch (err) ->
          console.log err

    return this
]
