# install dependencies
npm install

# keep track of your project's absolute path
PROJDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# we also keep orms absolute path
cd ./node_modules/orms/ && WDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# let orms do the magic..
# => codegen, build and run the project using your spec and business logic (./app/ folder)
prj=$PROJDIR root=$WDIR ./build_and_run.sh
