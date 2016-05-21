#pistahx-app 
(sample Haxe api using pistahx, pistahx-db, pistahx-spec)

### 1. BUILD LOCALLY


```
npm install -g gulp

npm install --only=dev

haxelib install ./node_modules/pistahx/gen/libs.hxml

gulp build

```

### 2. RUN LOCALLY

```
gulp run

```

#OR

### 1. BUILD FROM DOCKER (you can also use this image hosted on dockerhub : mebyz/pistahx-docker-build-stack)


```
docker build -f Dockerfile.build -t pistahx/build .

docker cp <container_id>:/app/distrib/out ./distrib/

```
=> your built app now resides in distrib/out

### 2. RUN FROM DOCKER 


```
docker build -f Dockerfile -t pistahx/run .

docker run pistahx/run

```
