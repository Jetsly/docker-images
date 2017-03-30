FROM node:7-alpine
RUN mkdir -p /usr/src/app
COPY package.json /usr/src/package.json
RUN cd /usr/src && npm install
WORKDIR /usr/src/app
EXPOSE 8018
CMD npm start


