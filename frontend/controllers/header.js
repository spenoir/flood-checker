export class HeaderController {

  /*@ngInject*/
  constructor($scope, $rootScope) {
    $rootScope.$on('$stateChangeSuccess',
      function(event, toState, toParams, fromState, fromParams){
        $scope.showMenu = false;
      }
    );

    $scope.toggleMenu = function() {
      $scope.showMenu = !$scope.showMenu;
    }

  }

}