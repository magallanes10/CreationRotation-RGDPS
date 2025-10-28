FROM node:18-alpine AS builder

WORKDIR /app/server

COPY package*.json ./
RUN npm install
RUN npm install -g typescript

COPY . .
RUN tsc && npx tsc-alias

FROM node:18-alpine

USER root

WORKDIR /app/server

COPY package*.json ./
RUN npm install --production

COPY --from=builder /app/server/out ./out
COPY . .

RUN chmod -R 755 /app

CMD ["node", "out/main.js"]
