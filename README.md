# pistahx-app : sample HAXE Webapi using pistahx, pistahx-db, pistahx-spec

https://github.com/mebyz/pistahx-app uses:

- https://github.com/mebyz/pistahx

- https://github.com/mebyz/pistahx-db

- https://github.com/mebyz/pistahx-spec

- https://github.com/mebyz/pistahx-ui	

#BUILD AND RUN LOCALLY

npm install -g gulp
npm install --only=dev
haxelib install ./node_modules/pistahx/gen/libs.hxml
gulp

#*******

#BUILD LOCAL APP USING DOCKER (your result package will reside in ./distrib/out)

docker build -f Dockerfile.build -t pistahx/build .
docker cp <container_id>:/app/distrib/out ./distrib/

=> your built app now resides in distrib/out
