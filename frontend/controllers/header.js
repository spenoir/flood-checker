export class HeaderController {

  /*@ngInject*/
  constructor($scope, $state, $stateParams, $rootScope, currentWarnings) {
    $scope.currentWarnings = currentWarnings.data.warnings.items;

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