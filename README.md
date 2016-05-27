#pistahx-app 
(sample Haxe api using pistahx, pistahx-db, pistahx-spec)

### 1. BUILD LOCALLY


```
./prepare.sh

gulp build

```

### 2. RUN LOCALLY

```
gulp run

```

#OR

### 1. BUILD FROM DOCKER

```
docker build -f Dockerfile.build -t pistahx/build .

docker run -d --name pistahx_build pistahx/build tail -f /dev/null

docker cp pistahx_build:/app/distrib/out ./distrib/out

```
=> your built app now resides in distrib/out

### 2. RUN WITH DOCKER-COMPOSE

```
docker-compose build

docker-compose up

```


