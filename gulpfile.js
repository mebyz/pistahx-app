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

// run task
gulp.task('aaa',  function(done) {


    fs.stat('./distrib/out/app.js', function(err, stat) {
            tasks= ['./injectRoutes.sh'];
	 gulp.src('test.js')
                .pipe(shell(tasks));
});
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
            tasks= ['echo "haxe run"'];

            tasks.push('echo "$VERT" "#APP: refresh Main.hx file" "$NORMAL"\n');
            tasks.push('cp -rf $WDIR/gen/Main.hx ./distrib/src/Main.hx\n');

            tasks.push('echo "$VERT" "#APP: generate db haxe typedefs to ./app/Business/models" "$NORMAL"');
            tasks.push('node_modules/pistahx-db/bin/sequelize-auto -d Chinook_Sqlite.sqlite -o ./app/Business/models/ -e sqlite -h localhost');

            tasks.push('echo "$VERT" "#APP: generate ./app/Business/TD.hx file from api.yaml with mebyz/yaml2hxzs" "$NORMAL"');
            tasks.push('input=./app/api.yaml output=./app/Business/TD.hx type=typedef node ./node_modules/pistahx-spec/yaml2hx.js ');

            tasks.push('echo "$VERT" "#APP: generate routes from spec and inject in Main.hx file" "$NORMAL"\n');
            tasks.push('input=./app/api.yaml output=./app/Business/Routes.hx type=routes node ./node_modules/pistahx-spec/yaml2hx.js\n');
            tasks.push('./injectRoutes.sh');
            tasks.push('\n');
            tasks.push('echo "$VERT" "#APP: Haxe transpilation" "$NORMAL"');
            tasks.push('cd ./distrib && haxe build.hxml && cd ..');

            tasks.push('echo "$VERT" "#APP: your project output will reside in ./distrib/out/" "$NORMAL"');
            tasks.push('#rm -rf ./distrib/out');
            tasks.push('rm -rf ./distrib/out/app.js');
            tasks.push('mkdir -p ./distrib/out 2>/dev/null || :');
            tasks.push('cp -rf ./app/api.yaml ./distrib/out/ 2>/dev/null || :');
            tasks.push('cp -rf ./distrib/app.js ./distrib/out/app.js 2>/dev/null || :');
            tasks.push('cp -rf ./distrib/node_modules ./distrib/out/ 2>/dev/null || :');
            tasks.push('cp -rf ./node_modules/pistahx/doc ./distrib/out/ 2>/dev/null || :');
            tasks.push('cp -rf ./app/conf ./distrib/out/ 2>/dev/null || :');
            tasks.push('cp -rf ./app/Business/sql ./distrib/out/ 2>/dev/null || :');
            tasks.push('cp -rf ./.ebignore ./distrib/out/ 2>/dev/null || :');
            tasks.push('ln -fs ./node_modules/pistahx/doc ./distrib/out/doc');
            tasks.push('  rm -rf ./distrib/out/site');
            tasks.push('  rm -rf ./distrib/out/models');
            tasks.push('  cp -rf ./site/dist/prod ./distrib/out/site');
            tasks.push('  cp -rf ./app/Business/models ./distrib/out/models');
            tasks.push('  cp -rf ./Chinook_Sqlite.sqlite ./distrib/out/');

            tasks.push('  ENV=$ENV node ./distrib/out/app.js');        
        return gulp.src('test.js')
                .pipe(shell(tasks));
    });

});

// build task, depends on execbuild
gulp.task('build', ['execbuild'], function(done) {
                tasks= ['echo "haxe build"'];

            tasks.push('echo "$VERT" "#APP: refresh Main.hx file" "$NORMAL"\n');
            tasks.push('cp -rf ./gen/Main.hx ./distrib/src/Main.hx\n');

            tasks.push('echo "$VERT" "#APP: generate db haxe typedefs to ./app/Business/models" "$NORMAL"');
            tasks.push('node_modules/pistahx-db/bin/sequelize-auto -d Chinook_Sqlite.sqlite -o ./app/Business/models/ -e sqlite -h localhost');

            tasks.push('echo "$VERT" "#APP: generate ./app/Business/TD.hx file from api.yaml with mebyz/yaml2hx" "$NORMAL"');
            tasks.push('type=typedef input=./app/api.yaml output=./app/Business/TD.hx node ./node_modules/pistahx-spec/yaml2hx.js ');

            tasks.push('echo "$VERT" "#APP: generate routes from spec and inject in Main.hx file" "$NORMAL"\n');
            tasks.push('input=./app/api.yaml output=./app/Business/Routes.hx type=routes node ./node_modules/pistahx-spec/yaml2hx.js\n');
            tasks.push('injectRoutes.sh');
            tasks.push('\n');
            tasks.push('echo "$VERT" "#APP: Haxe transpilation" "$NORMAL"');
            tasks.push('cd distrib');
            tasks.push('haxe build.hxml');
            tasks.push('cd -');
            gulp.src('test.js')
                .pipe(shell(tasks));
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
    })
    .on('end',function(){



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
        tasks.push('git clone git@github.com:mebyz/pistahx-ui.git site');
    }
    
    tasks.push('echo "$VERT" "#APP: let pistahx do the magic.." "$NORMAL"');
    tasks.push('echo "$VERT" " => codegen, build and run the project using your spec and business logic (./app/ folder)" "$NORMAL"');
    tasks.push('cd $WDIR');
    tasks.push('npm install --only=dev');
    tasks.push('cd $PROJDIR');

     return gulp.src('test.js')
                .pipe(shell(tasks));
});

