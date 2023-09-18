FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    nodejs \
    npm

RUN npm install --global yarn

WORKDIR /app

COPY . .

RUN yarn install

EXPOSE 9007

CMD ["yarn", "start"]