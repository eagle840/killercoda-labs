FROM ubuntu:18.04

# Run as root
USER root

WORKDIR /app

COPY package.json .

# Install dependencies
RUN apt-get update && apt-get install -y npm && npm install

COPY . .

CMD ["node", "index.js"]
