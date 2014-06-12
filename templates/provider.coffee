do (module)->
  ###**
   * @ngdoc object
   * @name <%= module %>.provider:<%= name %>
   *
   * @description
   * [description]
  ###
  module.provider '<%= name %>', di ($provide, $injector)->
    collection = []

    ###**
     * Allow $filter like getting a service
     *
     * @example
     * theService = providerName(anIdFromTheCollectionArray)
     * 
     * @return {Function} Gets a previously registered service
    ###
    @$get = -> 
      return (id)-> collection[id]

    @register = (id, configFn)->
      # Register services like factories
      # 
      # Example:
      # $provide.factory id, ($q)->
      #   collection[id] = (args)->
      #     invoked = $injector.invoke configFn
      #   return collection[id]
      #   
      # module.config (thisProvider)->
      #   thisProvider.register <id>, configFn
      return

    return this