FROM docker.io/node:24.5.0-alpine

COPY ./demo/demo-timers /app

WORKDIR /app

RUN npm ci --verbose

ENTRYPOINT ["npm", "start"]