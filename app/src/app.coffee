angular = require 'angular'
require 'angular-scroll'
require 'angular-filter'
require 'angular-local-storage'
require 'angular-animate'
require 'ng-lodash'
require '../../node_modules/angular-ui-bootstrap/dist/ui-bootstrap-tpls'
require 'angular-scroll'

app = require('angular').module('seibertsoftwaresolutions', [
  require 'angular-ui-router'
  require 'angular-resource'
  require 'angular-sanitize'
  require 'angular-moment'
  'ngAnimate'
  'duScroll'
  'angular.filter'
  'LocalStorageModule'
  'ngLodash'
  'ui.bootstrap'
  'duScroll'
])
app.value('duScrollDuration', 500)
app.value('duScrollOffset', 80)
app.config require './routes'
app.config [
  'localStorageServiceProvider'
  (
    localStorageServiceProvider
  ) ->

    localStorageServiceProvider
      .setPrefix 'seibertsoftwaresolutions'
]

require './main'

app.run [
  '$rootScope'
  '$http'
  (
    $rootScope
    $http
  ) ->

]
