gulp        = require 'gulp'
gutil       = require 'gulp-util'
$           = (require 'gulp-load-plugins')()


# Vars
DIST_LOCATION   = './dist'


###
@task: lint
@description: Lints our coffee script files.
###

gulp.task 'lint', ->
    gulp.src('./angular-slick.coffee')
    .pipe($.coffeelint())
    .pipe($.coffeelint.reporter())
    .pipe($.coffeelint.reporter('fail'))


###
@task: coffee
@description: Compiles the coffee script files.
###

gulp.task 'coffee', ->
    gulp.src('./angular-slick.coffee')
    .pipe($.sourcemaps.init())
    .pipe($.coffee({bare: true})
        .on('error', gutil.log))
    .pipe($.sourcemaps.write())
    .pipe($.size({ title: 'JS:' }))
    .pipe(gulp.dest("#{DIST_LOCATION}/"))


###
@task: minify
@description: Creates a minified version of the script.
###

gulp.task 'minify', ->
    gulp.src("#{DIST_LOCATION}/angular-slick.js")
    .pipe($.sourcemaps.init { loadMaps: true })
    .pipe($.uglify())
    .pipe($.sourcemaps.write('.'))
    .pipe($.size({ title: 'JS:' }))
    .pipe($.rename({suffix: '.min'}))
    .pipe(gulp.dest("#{DIST_LOCATION}/"))


###
@task: build
###

gulp.task 'build', ['lint', 'coffee', 'minify']
    