import 'babel/external-helpers';

import angular from 'angular';
import $ from 'jquery';
import _ from 'lodash';
import 'angular-route';
import 'angular-simple-logger';
import 'angular-google-maps';
import 'angular-bootstrap';


let app = angular.module('floodChecker',
  [
    'ngRoute', 'ui.bootstrap', 'ui.bootstrap.tpls',
    'uiGmapgoogle-maps', 'ui.router'
  ]
);

app.config(['$locationProvider', '$stateProvider',
  'uiGmapGoogleMapApiProvider', 'urlRouterProvider',
    function ($locationProvider, $stateProvider,
              uiGmapGoogleMapApiProvider, $urlRouterProvider) {

      $locationProvider.html5Mode(true).hashPrefix('!');

      $urlRouterProvider.otherwise("/warnings");

      $stateProvider
        .state('warnings', {
          url: "/warnings",
          templateUrl: "/frontend/partials/warnings.html"
        })
        .state('warnings.current', {
          url: "/warnings/current",
          templateUrl: "/frontend/partials/warnings-current.html",
          controller: 'WarningsCurrentController'
        })
        .state('warning', {
          url: "/warning",
          templateUrl: "/frontend/partials/warning.html"
        });

      // maps config
      uiGmapGoogleMapApiProvider.configure({
        key: 'AIzaSyDDDwic6PzI5QWWbfMH72JNA8f89ZRNvvc',
        v: '3.18',
        libraries: 'geometry'
      });

    }
]);

//angular.element(document).ready(function($ocLazyLoad) {
// angular.bootstrap(document.body, ['floodChecker'], {
//   strictDi: false
// });
//});

export default app;
