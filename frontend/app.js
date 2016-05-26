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
import { SearchController } from 'controllers/search';
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

      $stateProvider
        .state('root', {
          abstract: true,
          onEnter: function () {
            $('.loading').fadeOut('fast');
          },
          views: {
            'header@': {
              controller: HeaderController,
              templateUrl: '/frontend/partials/header.html'
            }
          },
          resolve: {
            currentWarnings: ['$http', function ($http) {
              return $http.get('/warnings/current/json');
            }]
          }
        })
        .state('root.home', {
          url: "/",
          parent: 'root',
          views: {
            '@': {
              controller: HomeController,
              templateUrl: '/frontend/partials/home.html'
            }
          }
        })
        .state('root.about', {
          url: "/about",
          views: {
            '@': {
              templateUrl: '/frontend/partials/about.html'
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
            warning: ['$http', '$stateParams', function ($http, $stateParams) {
              return $http.get('/warnings/' + $stateParams.slug + '/json/');
            }]
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
            warningsContext: ['$http', function ($http) {
              return $http.get('/warnings/json/');
            }]
          }
        })
        .state('root.search', {
          url: "/search/?q",
          views: {
            '@': {
              controller: SearchController
            }
          },
          resolve: {
            searchContext: ['$http', '$stateParms', function ($http, $stateParams) {
              return $http.get('/search/json/?q='+ $stateParams.q);
            }]
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
            warning: ['$http', '$stateParams', function ($http, $stateParams) {
              return $http.get('/warnings/' + $stateParams.slug + '/json/');
            }]
          }

        });

      uiGmapGoogleMapApiProvider.configure({
        key: 'AIzaSyCpz3aVqyXcPEp2lXGyDUfRSqyTliR4dSM',
        v: '3.23',
        libraries: 'geometry'
      });

    }
]);

export default app;