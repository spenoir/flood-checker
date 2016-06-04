'use strict';

export class SearchController {

  /*@ngInject*/
  constructor($scope, $http, $stateParams, searchContext, uiGmapGoogleMapApi){

    $scope.warnings = searchContext.data.warnings;
    $scope.query = _.has($stateParams, 'q') ? $stateParams.q : null;
    $scope.map = {
      center: {
       latitude: '51.500152',
       longitude: '-0.126236'
      },
      polygons: [],
      zoom: 11,
      control: {},
      bounds: $scope.bounds
    };

    uiGmapGoogleMapApi.then(function (maps) {
      $scope.bounds = new maps.LatLngBounds();

      angular.forEach($scope.warnings, function(warning, index) {

        $http.get(warning.floodArea.polygon).then( function (polygonData) {

          _.each(polygonData.data.features, function(polygon) {
            var id = 1;
            $scope.map.polygons.push(_.extend(polygon, {id: id, "geom": polygon.geometry}));

            _.map(polygon.geometry.coordinates, function(coords) {
              _.map(coords, function (coord) {
                _.map(coord, function (latLng) {
                  var latitudeLng = new maps.LatLng(latLng[1], latLng[0]);
                  $scope.bounds.extend(latitudeLng);
                });
              });
            });

            id++;

          });
        });
      });


      $scope.$watchCollection('map.polygons', function(newval, oldval) {
        $scope.map.center.latitude = $scope.bounds.getCenter().lat();
        $scope.map.center.longitude = $scope.bounds.getCenter().lng();

      });

    });
  }
}