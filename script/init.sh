#!/bin/bash

echo "Enter your local domain name (ex: local ou my-name.com)"
read -rp "> " response

echo "Generate .env"
echo PROXY_DOMAIN="$response" > .env;

if docker network ls | grep -qe ' *proxy *'; then
  echo "Proxy network already exit. Skip"
else
  echo "Create proxy network"
  docker network create proxy
fi

echo "Generate certificate"
mkcert -cert-file certs/default-cert.pem -key-file certs/default-key.pem "$response" "*.$response"

echo "Up container"
docker-compose up -d
