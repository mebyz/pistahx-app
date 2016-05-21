FROM mebyz/pistahx-docker-stack
MAINTAINER emmanuel.botros@gmail.com
WORKDIR /app
COPY distrib/out /app
#COPY /node_modules/* /app/node_modules/
RUN npm install sqlite3@3.1.3
EXPOSE  3000
CMD ["node", "/app/app.js"]
