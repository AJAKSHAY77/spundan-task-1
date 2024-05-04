# Stage 1: Build the Angular application
FROM node:16.14.0-alpine3.14 AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Stage 2: Serve the Angular application using Nginx
FROM nginx:1.21.5-alpine

COPY --from=build /app/dist/crud-app /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
