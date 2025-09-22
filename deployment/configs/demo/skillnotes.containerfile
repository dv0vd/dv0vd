FROM docker.io/node:24.5.0-alpine

COPY ./demo/demo-skillnotes /app

WORKDIR /app

RUN npm ci --verbose

ENTRYPOINT ["sh", "-c", "npm run migrate && npm start"]