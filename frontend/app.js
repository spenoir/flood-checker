import 'babel/external-helpers';

import angular from 'angular';
import $ from 'jquery';
import _ from 'lodash';
import 'angular-route';
import 'angular-simple-logger';
import 'angular-google-maps';
import 'angular-bootstrap';

import 'ocLazyLoad';

let app = angular.module('floodChecker',
  [
    'ngRoute', 'ui.bootstrap', 'ui.bootstrap.tpls',
    'uiGmapgoogle-maps', 'oc.lazyLoad'
  ]
);

app.config(['$routeProvider', '$locationProvider',
  'uiGmapGoogleMapApiProvider', '$ocLazyLoadProvider',
    function ($routeProvider, $locationProvider,
                uiGmapGoogleMapApiProvider, $ocLazyLoadProvider) {

      $locationProvider.html5Mode(true).hashPrefix('!');

      $ocLazyLoadProvider.config({
        debug: true
      });

      // routes config
      $routeProvider.
        when('/warnings/:slug', {
          templateUrl: '/frontend/partials/warning.html',
          controller: 'WarningController'
        });

      // maps config
      uiGmapGoogleMapApiProvider.configure({
        key: 'AIzaSyDDDwic6PzI5QWWbfMH72JNA8f89ZRNvvc',
        v: '3.18',
        libraries: 'geometry'
      });

    }
]);

//angular.element(document).ready(function() {
//  angular.bootstrap(document.body, ['floodChecker'], {
//    strictDi: false
//  });
//});

export default app;