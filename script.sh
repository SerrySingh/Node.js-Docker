#!/bin/bash

# Create working directory
mkdir node-docker
cd node-docker

# Install Node.js
sudo apt install -y npm

# Initialize a Node.js project
npm init -y

# Install dependencies
npm install ronin-server ronin-mocks

# Create server.js and add provided code
echo 'const ronin = require("ronin-server");
const mocks = require("ronin-mocks");

const server = ronin.server();

server.use("/", mocks.server(server.Router(), false, true));
server.start();' > server.js

# Create Dockerfile
echo 'FROM node:12.18.1

WORKDIR /app

COPY package.json package.json
COPY package-lock.json package-lock.json

RUN npm install

COPY . .
CMD ["node", "server.js"]' > Dockerfile

# Install Docker
sudo apt install -y docker.io

# Build Docker image
sudo docker build --tag node-docker .

# Display Docker images

sudo docker images

# Run Docker container
sudo docker run -p 8000:8000 node-docker
