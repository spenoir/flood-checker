'use strict';

import _ from 'lodash';

export class WarningController{

  /*@ngInject*/
  constructor($scope){
    debugger;
    $scope.warning = 'test';
  }

}

//export default angular.module('floodChecker')
//  .controller('WarningController',
//    ['$scope', '$location', '$rootScope', '$routeParams',
//      '$http', 'uiGmapGoogleMapApi', 'uiGmapIsReady',
//      function ($scope, $location, $rootScope, $routeParams,
//                $http, uiGmapGoogleMapApi, uiGmapIsReady) {
//        $http.get('/warnings/'+$routeParams.slug+'/json/').then( function (warning) {
//          $scope.warning = warning.data;
//
//          $scope.map = {
//            center: {
//             latitude: '51.500152',
//             longitude: '-0.126236'
//            },
//            polygons: [],
//            bounds: {},
//            zoom: 15
//
//          };
//
//          uiGmapGoogleMapApi.then(function (maps) {
//            $http.get($scope.warning.floodArea.polygon).then( function (polygon) {
//              $scope.polygons = polygon.data.features[0].geometry;
//              $scope.polygonMeta = polygon.data.features[0].properties;
//              $scope.polygons.type = "Polygon";
//              $scope.polygons.coordinates = $scope.polygons.coordinates[0];
//              $scope.map.polygons.push({id: 1, "geom": $scope.polygons});
//
//              _.map($scope.polygons.coordinates[0], function(coord) {
//                $scope.bounds = new maps.LatLngBounds();
//                var latLng = new maps.LatLng(coord[1], coord[0]);
//                $scope.bounds.extend(latLng);
//              });
//
//              uiGmapIsReady.promise(1).then(function(instances) {
//                instances.forEach(function(inst) {
//                  var map = inst.map;
//                  console.log('setting center to: ' + $scope.bounds.getCenter());
//
//                  $scope.map.center.latitude = $scope.bounds.getCenter().lat();
//                  $scope.map.center.longitude = $scope.bounds.getCenter().lng();
//
////                   $scope.map.bounds = {
////                       northeast: {
////                           latitude: $scope.bounds.getNorthEast().lat(),
////                           longitude: $scope.bounds.getNorthEast().lng()
////                       },
////                       southwest: {
////                           latitude: $scope.bounds.getSouthWest().lat(),
////                           longitude: $scope.bounds.getSouthWest().lng()
////                       }
////                   };
//                })
//
//              });
//            });
//
//          });
//        });
//
//      }
//    ]
//  );