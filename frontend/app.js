import 'babel/external-helpers';

import angular from 'angular';
import $ from 'jquery';
import _ from 'lodash';
import 'angular-route';
import 'angular-simple-logger';
import 'angular-google-maps';
import 'angular-bootstrap';
import 'angular-ui-router';
import 'angular-slugify';

import { HomeController } from 'controllers/home';
import { HeaderController } from 'controllers/header';
import { WarningsController } from 'controllers/warnings';
import { WarningController } from 'controllers/warning';

let app = angular.module('floodChecker',
  [
    'ngRoute', 'ui.bootstrap', 'ui.bootstrap.tpls',
    'uiGmapgoogle-maps', 'ui.router', 'slugifier'
  ]
);

app.config(['$locationProvider', '$stateProvider',
  'uiGmapGoogleMapApiProvider', '$urlRouterProvider',
    function ($locationProvider, $stateProvider,
              uiGmapGoogleMapApiProvider, $urlRouterProvider) {

      $locationProvider.html5Mode(true).hashPrefix('!');

      $urlRouterProvider.otherwise("/");

      $stateProvider
        .state('root', {
          abstract: true,
          views: {
            'header@': {
              controller: HeaderController,
              templateUrl: '/frontend/partials/header.html'
            }
          },
          resolve: {
            "currentWarnings": function($http) {
              return $http.get('/warnings/current/json');
            }
          }
        })
        .state('root.home', {
          url: "/",
          views: {
            '@': {
              controller: HomeController,
              templateUrl: '/frontend/partials/home.html'
            }
          }
        })
        .state('root.home.warning', {
          url: "^/warnings/:slug/",
          views: {
            '@': {
              templateUrl: "/frontend/partials/warning.html",
              controller: WarningController
            }
          },
          resolve: {
            warning: function ($http, $stateParams) {
              return $http.get('/warnings/' + $stateParams.slug + '/json/');
            }
          }

        })
        .state('root.warnings', {
          url: "/warnings/",
          views: {
            '@': {
              templateUrl: "/frontend/partials/warnings.html",
              controller: WarningsController
            }
          },
          resolve: {
            warningsContext: function ($http) {
              return $http.get('/warnings/json/');
            }
          }
        })
        .state('root.warnings.warning', {
          url: "^/warnings/:slug/",
          views: {
            '@': {
              templateUrl: "/frontend/partials/warning.html",
              controller: WarningController
            }
          },
          resolve: {
            warning: function ($http, $stateParams) {
              return $http.get('/warnings/' + $stateParams.slug + '/json/');
            }
          }

        });

      // maps config
      uiGmapGoogleMapApiProvider.configure({
        key: 'AIzaSyDDDwic6PzI5QWWbfMH72JNA8f89ZRNvvc',
        v: '3.18',
        libraries: 'geometry'
      });

    }
]);

export default app;
