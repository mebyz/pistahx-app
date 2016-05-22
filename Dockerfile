FROM mebyz/pistahx-docker-stack
MAINTAINER emmanuel.botros@gmail.com
WORKDIR /app
COPY distrib/out /app
RUN cd /app && npm install sqlite3 tedious
ENV ENV localdocker
EXPOSE  3000
CMD ["node", "/app/app.js"]
