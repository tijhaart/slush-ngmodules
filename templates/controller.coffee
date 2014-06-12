do (module)->
  ###**
   * @ngdoc object
   * @name <%= module %>.controller:<%= name %>
   * @function
   *
   * @description
   * [description]
  ###
  module.controller '<%= name %>', di ($scope)->
    return