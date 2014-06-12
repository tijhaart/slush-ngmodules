yargs   = require 'yargs'
path    = require 'path'
_str    = require 'underscore.string'
_       = require 'lodash'
path    = require 'path'

NGModule = (args)-> @main(args)

NGModule:: =
  main: (args)->
    _.defaults args,
      path: null

    @path = args.path
    @moduleFilename = path.basename @path.replace /\/src/gi, ''
    @ngModuleName   = _str.camelize @moduleFilename

    return @

# todo: refactor for re-using NGModule in gulpfile.coffee

module.exports = (modulepath)->

  module = new NGModule path: modulepath

  # [patrick] why don't we move this below to NGModule (prototype)?

  types =
    module:     'm'
    factory:    'f'
    service:    's'
    directive:  'd'
    provider:   'p'
    value:      'v'
    controller: 'c'
    config:     'o'
    constant:   'n'
    decorator:  'e'
    template:   't'
    style:      'y'

  args = _.reduce types, (args, option, type)->
    args
      .alias option, type
      .describe option, 'Create a new ' + type

    return args

  , yargs
      .demand ['m']

  # _.forEach args, (arg, key)-> console.log arg, key

  pluralize = (type) ->
    plurals =
      factory: 'factories'
      service: 'services'
      directive: 'directives'
      provider: 'providers'
      value: 'values'
      controller: 'controllers'
      constant: 'constants'
      decorator: 'decorators'
      template: 'templates'
      style: 'styles'
    return type = if plurals[type] then plurals[type] else type

  isModuleOnly = (_.filter types, (option, type)-> args.argv[type]).length == 1 && args.argv['module']?

  filesToCreate = _.reduce args.argv, (result, optionVal, type)->
    if types[type]?

      filename = (_str.ltrim (_str.dasherize optionVal), ['-'])
      ext = '.coffee'

      switch type
        when 'template' then ext = '.jade'
        when 'style' then ext = '.scss'

      if optionVal.indexOf('_') == 0
        filename = '_' + (_str.ltrim (_str.dasherize optionVal), ['-'])


      if type != 'module'
        result.push
          modulepath: module.path
          template: path.join __dirname, '/templates/', type + ext
          dest:  path.join '/src/', pluralize(type), filename + ext
          templateData:
            # util
            _s: _str
            # data
            module: module.ngModuleName
            type: type
            name: _str.camelize optionVal
            filename: filename
      else if isModuleOnly
        result.push
          modulepath: module.path
          template: path.join __dirname, '/templates/', type + ext
          dest: path.join '/src/' + 'index' + ext
          templateData:
            # util
            _s: _str
            # data
            module: module.ngModuleName
            type: type
            name: module.ngModuleName

    return result
  , []

  yargs.resetOptions()

  return filesToCreate