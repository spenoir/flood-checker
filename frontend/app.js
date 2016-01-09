import 'babel/external-helpers';

import angular from 'angular';
import $ from 'jquery';
import _ from 'lodash';
import 'angular-route';
import 'angular-simple-logger';
import 'angular-google-maps';
import 'angular-bootstrap';
import 'angular-ui-router';

import { BaseController } from 'controllers/base';
import { HomeController } from 'controllers/home';
import { HeaderController } from 'controllers/header';
import { WarningsController } from 'controllers/warnings';
import { WarningController } from 'controllers/warning';
import { WarningsCurrentController } from 'controllers/warnings-current';

let app = angular.module('floodChecker',
  [
    'ngRoute', 'ui.bootstrap', 'ui.bootstrap.tpls',
    'uiGmapgoogle-maps', 'ui.router'
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
        .state('root.warnings', {
          url: "/warnings/",
          views: {
            '@': {
              templateUrl: "/frontend/partials/warnings.html",
              controller: WarningsController
            }
          }
        })
        .state('root.warnings.current', {
          url: "/warnings/current/",
          views: {
            '@': {
              templateUrl: "/frontend/partials/warnings-current.html",
              controller: WarningsCurrentController
            }
          }

        })
        .state('root.warning', {
          url: "/warning/",
          views: {
            '@': {
              templateUrl: "/frontend/partials/warning.html",
              controller: WarningController
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
