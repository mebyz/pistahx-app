# pistahx-app : sample HAXE Webapi using pistahx, pistahx-db, pistahx-spec

https://github.com/mebyz/pistahx-app uses:

- https://github.com/mebyz/pistahx

- https://github.com/mebyz/pistahx-db

- https://github.com/mebyz/pistahx-spec

- https://github.com/mebyz/pistahx-ui	

# local build & run

npm install -g gulp
npm install --only=dev
haxelib install ./node_modules/pistahx/gen/libs.hxml
gulp

# docker build (see Dockerfile.build for details)

docker build -f Dockerfile.build -t pistahx/build .
docker run pistahx/build .

# docker run (see Dockerfile for details)
docker build -f Dockerfile -t pistahx/run .
docker run -e ENV=localdocker pistahx/run .


