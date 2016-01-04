export class WarningsController {

  /*@ngInject*/
  constructor($scope, warningsContext){
    $scope.warnings = warningsContext.data.warnings;
    $scope.current = warningsContext.data.current;
  }

}