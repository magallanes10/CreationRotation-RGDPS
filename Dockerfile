FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install
RUN npm install -g typescript

COPY . .
RUN tsc && npx tsc-alias

FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY --from=builder /app/out ./out
COPY migrations ./migrations
COPY src ./src

RUN chmod -R 755 /app

CMD ["node", "out/main.js"]
