export class SearchController {

  /*@ngInject*/
  constructor($scope, $http, searchContext, uiGmapGoogleMapApi, uiGmapIsReady){


    $scope.map = {
      center: {
       latitude: '51.500152',
       longitude: '-0.126236'
      },
      polygons: [],
      zoom: 11,
      control: {},
      bounds: {}

    };

    uiGmapGoogleMapApi.then(function (maps) {
      $scope.bounds = new maps.LatLngBounds();

      angular.forEach(searchContext.data.warnings, function(warning, index) {

        $http.get(warning.floodArea.polygon).then( function (polygon) {

          var poly = polygon.data.features[0].geometry;
          angular.forEach(poly.coordinates, function(coords) {

            $scope.map.polygons.push({id: warning.slug, "geom": {
                coordinates: coords,
                type: "Polygon"
              }
            });

            angular.forEach(coords[0], function(c) {
              var latLng = new google.maps.LatLng(c[1], c[0]);
              $scope.bounds.extend(latLng);
            });

          });
        });

      });



      $scope.$watchCollection('map.polygons', function(newval, oldval) {

        $scope.map.center.latitude = $scope.bounds.getCenter().lat();
        $scope.map.center.longitude = $scope.bounds.getCenter().lng();

        //$scope.map.bounds = {
        //    northeast: {
        //      latitude: $scope.bounds.getNorthEast().lat(),
        //      longitude: $scope.bounds.getNorthEast().lng()
        //    },
        //    southwest: {
        //      latitude: $scope.bounds.getSouthWest().lat(),
        //      longitude: $scope.bounds.getSouthWest().lng()
        //    }
        //  };

          //var gmap = $scope.map.control.getGMap();
          //gmap.fitBounds($scope.bounds);

      });


    });
  }
}