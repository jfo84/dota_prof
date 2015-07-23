@thumbnailer = angular.module('thumbnailer', ['ngRoute', 'ngResource', 'ngSanitize', 'templates'])

@thumbnailer.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.
    otherwise({
      templateUrl: 'thumbnails/new.html',
      controller: 'ThumbnailsCtrl'
    })
])
