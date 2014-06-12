do (module)->
  ###**
   * @ngdoc object
   * @name <%= module %>.factory:<%= name %>
   *
   * @description
   * [description]
  ###
  module.factory '<%= name %>', di ->
    create: ->
      return