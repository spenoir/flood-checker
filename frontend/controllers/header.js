'use strict';

import _ from 'lodash';

export default angular.module('floodChecker')
  .controller('HeaderController',
    ['$scope', '$location', '$rootScope', '$routeParams',
      function ($scope, $location, $rootScope, $routeParams) {
        $scope.showMenu = false;

        $scope.toggleMenu = function() {
          $scope.showMenu = !$scope.showMenu;
        }
      }
    ]);