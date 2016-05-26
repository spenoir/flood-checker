'use strict';

export class WarningController {

  /*@ngInject*/
  constructor($scope, $stateParams, $http,
              uiGmapGoogleMapApi, uiGmapIsReady, warning){
    $scope.warning = warning.data;
    $scope.slug = $stateParams.slug;

    $scope.map = {
      center: {
       latitude: '51.500152',
       longitude: '-0.126236'
      },
      polygons: [],
      zoom: 15

    };

    $http.get($scope.warning.floodArea.polygon).then( function (polygonData) {
      $scope.bounds = new maps.LatLngBounds();

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

      $scope.map.center.latitude = $scope.bounds.getCenter().lat();
      $scope.map.center.longitude = $scope.bounds.getCenter().lng();

      uiGmapIsReady.promise(1).then(function(instances) {
        instances.forEach(function(inst) {
          var map = inst.map;
          console.log('loaded map with center of: ' + $scope.bounds.getCenter());
        })

      });
    });

  }

}