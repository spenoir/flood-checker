import _ from 'lodash';
import 'app';
//import 'services';
//import 'controllers/header';
//import 'controllers/warnings';
//import 'controllers/warning';


angular.element(document).ready(function($ocLazyLoad) {
 angular.bootstrap(document.body, ['floodChecker'], {
   strictDi: false
 });
});