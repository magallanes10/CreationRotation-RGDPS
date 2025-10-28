FROM node:18-alpine AS builder

WORKDIR /app/server

COPY server/package*.json ./
RUN npm install
RUN npm install -g typescript

COPY server/ . .
RUN tsc && npx tsc-alias

FROM node:18-alpine

WORKDIR /app/server

COPY server/package*.json ./
RUN npm install --production

COPY --from=builder /app/server/out ./out

RUN chmod -R 755 /app

CMD ["node", "out/main.js"]
