#!/bin/bash
apt update && apt install -y jq git curl sed

if [ ! -d "/opt/mailcow-dockerized" ]; then
    git clone https://github.com/mailcow/mailcow-dockerized /opt/mailcow-dockerized
fi

cd /opt/mailcow-dockerized

sed -i 's/HTTP_PORT=80/HTTP_PORT=8080/g' generate_config.sh
sed -i 's/HTTPS_PORT=443/HTTPS_PORT=8443/g' generate_config.sh
sed -i 's/HTTP_BIND=/HTTP_BIND=127.0.0.1/g' generate_config.sh
sed -i 's/HTTPS_BIND=/HTTPS_BIND=127.0.0.1/g' generate_config.sh

if [ ! -f "mailcow.conf" ]; then
    export MAILCOW_HOSTNAME="mail.irkol.com"
    export TZ="Europe/Prague"
    ./generate_config.sh
fi

sed -i 's/172.22.1/172.25.1/g' docker-compose.yml
docker compose up -d

cd ~/irkol
docker compose up -d