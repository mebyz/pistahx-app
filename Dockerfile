FROM mebyz/pistahx-docker-stack
MAINTAINER emmanuel.botros@gmail.com
WORKDIR /app
COPY distrib/out /app
EXPOSE  3000
CMD ["node", "/app/app.js"]
