do (module)->
  ###**
   * @ngdoc directive
   * @name <%= module %>.directive:<%= name %>
   * @element ANY
   *
   * @description
   * [description]
   *
   * @example
     <div <%= _s.ltrim(_s.dasherize(name),'-') %>></div>
  ###
  module.directive '<%= name %>', di ()->
    restrict: 'A'
    controller: di ($scope)->
      return 
    link: ($scope, $el, attrs, ctrl)->
      return