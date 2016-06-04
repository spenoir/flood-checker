export class HeaderController {

  /*@ngInject*/
  constructor($scope, $state, $stateParams, $rootScope, currentWarnings) {
    $scope.currentWarnings = currentWarnings.data.warnings.items;
    $scope.query = _.has($stateParams, 'q') ? $stateParams.q : null;

    $scope.$on('$stateChangeSuccess',
      function(event, toState, toParams, fromState, fromParams){
        $scope.showMenu = false;
      }
    );

    $scope.search = function (query) {
      return $state.go('root.search', {
        q: $scope.query || query
      });
    };

    $scope.toggleMenu = function() {
      $scope.showMenu = !$scope.showMenu;
    }

  }

}