FROM node:alpine as builder
WORKDIR /app
ADD package.json ./
RUN npm ci
ADD . .
RUN npm run build --production

FROM node:alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist /app/
ADD package*.json ./
RUN npm ci --omit=dev
CMD ["node","./dist/main.js"]