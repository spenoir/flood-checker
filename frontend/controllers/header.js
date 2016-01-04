export class HeaderController {

  /*@ngInject*/
  constructor($scope) {
    $scope.toggleMenu = function() {
      $scope.showMenu = !$scope.showMenu;
    }

  }

}