var gulp = require('gulp');
var shell = require('gulp-shell');
var gutil = require('gulp-util');
var fs = require('fs');
var prompt = require('gulp-prompt');
var spawn = require('child_process').spawn;
var inquirer = require('inquirer');

// default task, set env
gulp.task('default', function(done) {

    process.env.VERT="\\033[1;32m";
    process.env.NORMAL="\\033[0;39m";
    process.env.ROUGE="\\033[1;31m";
    process.env.WDIR="./node_modules/pistahx";
    process.env.PROJDIR=__dirname;

    gulp.start('set-task');
});

// set-task, user prompt
gulp.task('set-task', function(done) {
    gulp.src('test.js')
    .pipe(prompt.prompt({
        type: 'rawlist',
        name: 'type',
        message: 'Which task do you want to execute ?',
        choices: ['run', 'build']
    }, function (res) {
        if(res.type=='build') {
            process.env.mode = 'build';
            gulp.start('build');
            done();
        }
        if(res.type=='run') {
            process.env.mode = 'run';
            gulp.start('run');
            done();
        }
        
    }));
});

// run task
gulp.task('run',  function(done) {

    process.env.ENV = 'local';

    fs.stat('./distrib/out/app.js', function(err, stat) {
        if(err == null) {
            tasks= ['  echo "$VERT" "#PISTAHX: trying to start API" "$NORMAL"'];
            tasks.push('  rm -rf ./distrib/out/site');
            tasks.push('  cp -rf ./site/dist/prod ./distrib/out/site');
            tasks.push('  ENV=$ENV node ./distrib/out/app.js');        
        } else {
            tasks= ['  echo "$ROUGE" "#!ERROR : please build first :)" "$NORMAL"'];
        }
        return gulp.src('test.js')
                .pipe(shell(tasks));
    });

});

// build task, depends on execbuild
gulp.task('build', ['execbuild'], function(done) {
    console.log("Build done !");
    done();
});

// execbuild task, depends on prebuild
gulp.task('execbuild', ['prebuild'], function(done) {
    // this will execute pistahx's gulpfile.js !
    process.chdir(process.env.WDIR);
    var cmd = 'mode=build prj=../../ root=./ gulp build';
    gulp.src('', {read: false})
    .pipe(shell(cmd))
    .on('error', function (err) {
       console.log(err);
    });  
});

// prebuild task
gulp.task('prebuild', function(done) {
    var tasks = ['echo "$VERT" "#APP: triggering build in mode:$mode" "$NORMAL"'];

    if (process.env.mode == 'build') {
        tasks.push('echo "$VERT" "#APP: install project dependencies" "$NORMAL"');
        tasks.push('npm install');
    }

    tasks.push('echo "$VERT" "#APP: update project dependencies" "$NORMAL"');
    tasks.push('npm update');

    if (process.env.mode == 'build') {
        tasks.push('echo "$VERT" "#APP: pull companion website" "$NORMAL"');
        tasks.push('rm -rf site');
        tasks.push('mkdir site');
        tasks.push('cp -rf ./node_modules/pistahx-ui/* ./site/');
    }
    
    tasks.push('echo "$VERT" "#YOUR_APP: generate db haxe typedefs to ./app/Business/models" "$NORMAL"');
    tasks.push('node_modules/pistahx-db/bin/sequelize-auto -d Chinook_Sqlite.sqlite -o ./app/Business/models/ -e sqlite -h localhost');

    tasks.push('echo "$VERT" "#APP:generate ./app/Business/TD.hx file from api.yaml with mebyz/yaml2hx" "$NORMAL"');
    tasks.push('input=./app/api.yaml output=./app/Business/TD.hx node ./node_modules/pistahx-spec/yaml2hx.js ');

    tasks.push('echo "$VERT" "#APP: let pistahx do the magic.." "$NORMAL"');
    tasks.push('echo "$VERT" " => codegen, build and run the project using your spec and business logic (./app/ folder)" "$NORMAL"');
    tasks.push('cd $WDIR');
    tasks.push('npm install --only=dev');
    tasks.push('cd $PROJDIR');

     return gulp.src('test.js')
                .pipe(shell(tasks));
});

