'use strict';

export class HomeController {

  /*@ngInject*/
  constructor($scope, currentWarnings) {
    $scope.currentWarnings = currentWarnings.data.warnings.items;
  }

}