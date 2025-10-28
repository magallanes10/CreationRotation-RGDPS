FROM node:18-alpine AS builder

WORKDIR /app/server

COPY server/package*.json ./
RUN npm install

COPY server/ . .
RUN npm run build

FROM node:18-alpine

WORKDIR /app/server

COPY server/package*.json ./
RUN npm install --production

COPY --from=builder /app/server/out ./out

RUN chmod -R 755 /app

CMD ["node", "out
