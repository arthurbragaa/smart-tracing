FROM node:10 AS ts-builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
RUN npm run clean

FROM node:10 AS ts-prod
WORKDIR /app
EXPOSE 8080
COPY --from=ts-builder ./app/public ./public
COPY package* ./
RUN npm install --production
