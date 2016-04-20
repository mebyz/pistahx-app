var gulp = require('gulp');
var shell = require('gulp-shell');
var gutil = require('gulp-util');


gulp.task('run', shell.task([
    './run.sh'
  ])
);

gulp.task('kill', shell.task([
    'killall node'
  ])
);

gulp.task('build', shell.task([
    './build.sh',
    './run.sh '
  ])
);

gulp.task('default', ['build']);
