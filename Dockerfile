FROM node:20.10.0-alpine as base
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:20.10.0-alpine as production
ENV NODE_ENV=production
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY --from=base /app/build ./build

EXPOSE 3000
CMD ["./node_modules/.bin/serve", "-s", "build"]
