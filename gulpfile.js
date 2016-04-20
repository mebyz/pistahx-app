var gulp = require('gulp');
var shell = require('gulp-shell');
var gutil = require('gulp-util');
var prompt = require('gulp-prompt');

gulp.task('run', shell.task([
    './run.sh'
  ])
);

gulp.task('kill', shell.task([
    'killall node'
  ])
);

gulp.task('build', shell.task(['./build.sh']));

var inquirer = require('inquirer');

gulp.task('default', function(done) {
    inquirer.prompt([{
        type: 'confirm',
        message: 'Do you really want to rebuild all ?',
        default: true,
        name: 'start'
    }], function(answers) {
        if(answers.start) {
            gulp.start('build');
        }
	else {
	    gulp.start('run');
	}
        done();
    });
});
