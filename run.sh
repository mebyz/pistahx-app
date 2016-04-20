VERT="\\033[1;32m"
NORMAL="\\033[0;39m"
ROUGE="\\033[1;31m"

if [ "$mode" != "build" ] ; then
mode=run
fi

if [ "$lang" != "ts" ] ; then
lang=haxe
fi

echo "$VERT" "#YOUR_APP: triggering build in mode:$mode" "$NORMAL"


echo "$VERT" "#YOUR_APP: keep track of your project's absolute path" "$NORMAL"
PROJDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "$VERT" "#YOUR_APP: keep track of pistahx absolute path" "$NORMAL"
cd ./node_modules/pistahx/ && WDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


if [ "$mode" = "build" ] ; then

echo "$VERT" "#YOUR_APP: install project dependencies" "$NORMAL"
npm install --loglevel error

echo "$VERT" "#YOUR_APP: update project dependencies" "$NORMAL"
npm update --loglevel error

echo "$VERT" "#YOUR_APP: pull companion website (you must enable this step in run.sh)" "$NORMAL"
rm -rf site
git clone git@github.com:mebyz/SB-Admin-BS4-Angular-2.git site

echo "$VERT" "#YOUR_APP: generate db haxe typedefs to ./app/Business/models" "$NORMAL"
node_modules/pistahx-db/bin/sequelize-auto -d Chinook_Sqlite.sqlite -o ./app/Business/models/ -e sqlite -h localhost

echo "$VERT" "#YOUR_APP:generate ./app/Business/TD.hx file from api.yaml with mebyz/yaml2hx" "$NORMAL"
input=./app/api.yaml output=./app/Business/TD.hx node ./node_modules/pistahx-spec/yaml2hx.js

fi

echo "$VERT" "#YOUR_APP: let pistahx do the magic.." "$NORMAL"
echo "$VERT" " => codegen, build and run the project using your spec and business logic (./app/ folder)" "$NORMAL"


if [ "$lang" == "haxe" ] ; then
mode=$mode prj=$PROJDIR root=$WDIR ./build_and_run.sh
mode=$mode node $PROJDIR/distrib/out/app.js
fi

if [ "$lang" == "ts" ] ; then
mode=$mode prj=$PROJDIR root=$WDIR ./build_and_run2.sh
fi
