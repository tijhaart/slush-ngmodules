do (module)->
  ###**
   * @ngdoc service
   * @name <%= module %>.service:<%= name %>
   *
   * @description
   * [description]
  ###  
  module.service '<%= name %>', di ()->
    @fn = -> return 'fn'

    return this