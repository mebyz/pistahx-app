!/bin/bash
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

if [ "$mode" = "build" ] ; then
echo "$VERT" "#YOUR_APP: install project dependencies" "$NORMAL"
npm install
echo "$VERT" "#YOUR_APP: update project dependencies" "$NORMAL"
npm update
echo "$VERT" "#YOUR_APP: pull companion website (you must enable this step in run.sh)" "$NORMAL"
#rm -rf site
#git clone [YOUR FRONT REPOSITORY] site
fi
echo "$VERT" "#YOUR_APP: keep track of your project's absolute path" "$NORMAL"
PROJDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "$VERT" "#YOUR_APP: keep track of orms absolute path" "$NORMAL"
cd ./node_modules/orms/ && WDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "$VERT" "#YOUR_APP: let orms do the magic.." "$NORMAL"
echo "$VERT" " => codegen, build and run the project using your spec and business logic (./app/ folder)" "$NORMAL"


if [ "$lang" == "haxe" ] ; then
mode=$mode prj=$PROJDIR root=$WDIR ./build_and_run.sh
fi

if [ "$lang" == "ts" ] ; then
mode=$mode prj=$PROJDIR root=$WDIR ./build_and_run2.sh
fi
