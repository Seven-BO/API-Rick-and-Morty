FROM node:18-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build -- --output-path=./dist --configuration=production

RUN ls -la /app/dist

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/dist/api-ricky-morty /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]