FROM node:18-alpine

WORKDIR /app

RUN npm install -g pm2

RUN pm2 --version

COPY . .

RUN yarn install

EXPOSE 9007

CMD [ "yarn", "start" ]