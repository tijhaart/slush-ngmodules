"use strict"

yargs       = require 'yargs'
gulp        = require 'gulp'
lazypipe    = require 'lazypipe'
glob        = require 'glob'
path        = require 'path'
inquirer    = require 'inquirer'
through     = require 'through2'
fs          = require 'fs'
_           = require 'lodash'


gutil       = require 'gulp-util'
gdebug      = require 'gulp-debug'
gulpif      = require 'gulp-if'
clean       = require 'gulp-clean'
coffee      = require 'gulp-coffee'
concat      = require 'gulp-concat'
wrap        = require 'gulp-wrap'
jade        = require 'gulp-jade'
template    = require 'gulp-template'
rename      = require 'gulp-rename'
conflict    = require 'gulp-conflict'
ngtpl       = require 'gulp-angular-templatecache'
prompt      = require 'gulp-prompt' # rm

ngmodule = require './ngmodule'

###*
 * Prompt user to replace an existing file or not
 * @param  {String} filepath - Path to root of the given module
 * @param  {Object} args
 * @param  {String} args.cwd - Optionally pass another absolute path for the target
 * @return {Stream}
###
ask = (filepath, args={})->
  _.defaults args,
    cwd: process.cwd()

  return through.obj (file, enc, cb)->
    self = this
    target = path.join args.cwd, filepath, file.relative      

    if fs.existsSync target
      inquirer.prompt [
          type: 'confirm'
          name: 'replace'
          message: "[conflict] Replace '#{file.relative}'?"
          default: true
      ], callback = (answer)-> if answer.replace then cb null, file else cb(null, null); self.emit 'end'           

    else 
      return cb null, file

gulp.task 'default', ->
  argv = yargs
    .alias 'm', 'module'
    .demand 'm'
    .boolean ['verbose', 'debug']
    .argv

  yargs.resetOptions()

  debug = lazypipe()
    .pipe gulpif, ( argv.verbose or argv.debug ), gdebug( verbose: ( argv.debug and argv.verbose ) )

  base = "./client/src/ng-modules/"
  modulepath = './' + path.normalize path.join base, argv.module

  files = ngmodule(modulepath)

  console.log files

  pendingStreams = files.map (file)->
    return (lazypipe()
      .pipe gulp.src, file.template
      .pipe template, file.templateData
      .pipe rename,   file.dest
      .pipe ask,      file.modulepath
      .pipe gulp.dest, file.modulepath
    )

  streams = pendingStreams.map (pendingStream)->
    pendingStream()


  return streams


  ###
  # @TODO: figure out how to pause the stream to ask for replacing the file if it's already there
  ask = (filepath)->
    return through.obj (file, enc, cb)->
      target = path.join process.cwd(), filepath, file.relative
      # todo: pause stream
      fs.exists target, (exists)->
        if exists
          inquirer.prompt [
              type: 'confirm'
              name: 'replace'
              message: "[conflict] Replace '#{file.relative}'?"
              default: false
          ], callback = (answer)->
              console.log 'calling back', answer
        # else cb file
  ###