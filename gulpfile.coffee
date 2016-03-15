fs = require 'fs'
gulp = require 'gulp'
mkdir = require 'mkdirp'
data = require 'gulp-data'
gulpLoadPlugins = require 'gulp-load-plugins'
pkg = require './package.json'
_ = require 'lodash'

# define
approot = 'app'
distMode = 'dev'
domain = '//static.xiaojukeji.com'
{routerPath,distPath}=
routerPath: pkg.routerPath
distPath: "#{approot}/#{distMode}"
console.log "pkg.routerPath", pkg.routerPath

# define plugins
{
util,
jade,
stylus,
coffee,
sourcemaps
}=gulpLoadPlugins
  pattern: 'gulp-*'
  scope: ['dependencies']
  replaceString: 'gulp-'
  camelize: true
  lazy: true

# define webroot with domain
wwwroot = domain + routerPath

# the empty project init
gulp.task 'init', (cb) ->
  jade = approot + '/src/jade'
  stylus = approot + '/src/stylus'
  coffee = approot + '/src/coffee'
  vender = approot + '/src/vender'
  img = approot + '/src/img'
  mock = approot + '/mock/'

  doc = [
    "#{jade}/layout"
    "#{jade}/module"
    "#{stylus}/module"
    "#{stylus}/font"
    "#{coffee}/lib"
    "#{coffee}/module"
    "#{vender}"
    "#{img}"
    "#{mock}"
  ]
  for val in doc
    mkdir.sync val
  cb()

# set dev
gulp.task 'setDev', [], ()->
  distMode = 'dev'
  distPath = approot + '/' + distMode

#jade
gulp.task 'jade', ()->
  LOCALS =
    wwwroot: wwwroot
  gulp.src [approot + '/src/jade/**/*.jade', '!' + approot + '/src/jade/layout/*.*',
    '!' + approot + '/src/jade/module/**/*.jade']
  .pipe data (file)->
    $CONFIG = file.path.replace(/\.jade/, '\_$config\.json')

    if fs.existsSync($CONFIG)
      _data = _.assign({}, JSON.parse(fs.readFileSync($CONFIG)), LOCALS)
      return _data;
    else
      _data = _.assign({}, {}, LOCALS);
      return _data;
  .pipe jade
    pretty: true
  .pipe gulp.dest distPath + '/html/'

# stylus - with sourcemaps
gulp.task 'stylus', ()->
  isCompress = distMode is 'dist'
  console.log 'is Compress mode : ', isCompress
  gulp.src [approot + '/src/stylus/**/*.styl', '!' + approot + '/src/stylus/module/**/*.styl']
  .pipe sourcemaps.init()
  .pipe stylus
    compress: isCompress
  .pipe sourcemaps.write '.maps'
  .pipe gulp.dest distPath + '/css/'

# coffee
gulp.task 'coffee', ()->
  gulp.src [approot + '/src/coffee/**/*.coffee', '!' + approot + '/src/coffee/module/**/*.coffee']
  .pipe sourcemaps.init()
  .pipe coffee
    bare: true
  .on 'error', util.log
  .pipe sourcemaps.write '.maps'
  .pipe gulp.dest distPath + '/js/'

  #支持不熟悉coffee的同学直接写js
  gulp.src approot + '/src/coffee/**/*.js'
  .pipe gulp.dest distPath + '/js'

# copy vender
gulp.task 'cpVender', ()->
  gulp.src approot + '/src/vender/**/*.*'
  .pipe gulp.dest distPath + '/vender'

# copy images
gulp.task 'cpImg', ()->
  gulp.src approot + '/src/img/**/*.*'
  .pipe gulp.dest distPath + '/img'

gulp.task 'compile', ['jade', 'stylus', 'coffee', 'cpVender', 'cpImg']
gulp.task 'dev', ['setDev', 'compile']
gulp.task 'default', ['init']