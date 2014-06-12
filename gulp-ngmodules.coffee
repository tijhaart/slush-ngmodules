yargs       = require('yargs')
through     = require 'through2'
gulp        = require 'gulp'
gutil       = require 'gulp-util'
fs          = require 'fs'
_           = require 'lodash'
_str        = require 'underscore.string'
path        = require 'path'

clean       = require 'gulp-clean'
coffee      = require 'gulp-coffee'
concat      = require 'gulp-concat'
wrap        = require 'gulp-wrap'
jade        = require 'gulp-jade'
template    = require 'gulp-template'
rename      = require 'gulp-rename'
conflict    = require 'gulp-conflict'
ngtpl       = require 'gulp-angular-templatecache'

NGModule    = require './ngmodule'

module.exports = ngmodules = ->
  
  console.log 'args', arguments

  # console.log new NGModule path: './ng-modules/ui/src'

  ###*
   * @todo check if isDir
   * @todo inspect cli arg module glob
  ###
  return through.obj (dir, enc, cb)->

    # filesToCreate.forEach (file)->
      # gulp.src file.template
      #   .pipe template(file.templateData)
      #   .pipe rename file.dest
      #   # conflict
      #   .pipe gulp.dest module.path
    

    # create a stream for each new file
    
    # result = _.transform args.argv, (result, arg, index)->
    #   result[index] = arg
    #   return result

    # coffee = ->
    #   gulp.src __dirname + '/templates/controller.coffee'
    #     .pipe template(name:'bar')
    #     .pipe rename target
    #     # conflict
    #     .pipe gulp.dest module.path

    # coffee()


    # js = gutil.combine(
    #   coffee( bare: true ),
    #   concat( module.ngModuleName + '.js' )
    # )


    # _.forEach file, (value, key)->
    #   console.log key, ' : ', value

    cb()