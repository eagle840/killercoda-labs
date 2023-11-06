# Step 3

running trough docker

WIP   this doesn't work

`docker run --rm -v "$(pwd)":/app -w /app node:latest npx prettier --check .`{{exec}}


Dockerfile

```
FROM node:18

WORKDIR /app

# COPY package.json yarn.lock ./

RUN apt-get update && apt-get install -y libvips

RUN yarn install

COPY . .

CMD ["yarn", "start"]
```


docker-compose.yml
```
version: '3'
services:
  node-app:
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - .:/app
    environment:
      - SKIP_RUBY=false
      - SKIP_NODE=false
      - NODE_VERSION=18.x
```