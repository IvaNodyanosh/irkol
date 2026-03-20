#!/bin/bash
git clone https://github.com/mailcow/mailcow-dockerized /opt/mailcow-dockerized

cd /opt/mailcow-dockerized
./generate_config.sh

sed -i 's/HTTP_PORT=80/HTTP_PORT=8080/g' mailcow.conf
sed -i 's/HTTPS_PORT=443/HTTPS_PORT=8443/g' mailcow.conf
sed -i 's/HTTP_BIND=/HTTP_BIND=127.0.0.1/g' mailcow.conf
sed -i 's/HTTPS_BIND=/HTTPS_BIND=127.0.0.1/g' mailcow.conf

docker compose up -d

cd /opt/my-site
docker compose up -d