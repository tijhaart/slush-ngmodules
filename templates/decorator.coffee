do (module)->
  ###**
   * @ngdoc object
   * @name <%= module %>.decorator:<%= name %>
   *
   * @description
   * [description]
  ###
  module.config di ($provide)->
    $provide.decorator '<%= name %>', di ($delegate)->
      return $delegate