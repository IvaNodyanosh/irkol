#!/bin/bash
git clone https://github.com/mailcow/mailcow-dockerized /opt/mailcow-dockerized

cd /opt/mailcow-dockerized
./generate_config.sh
docker compose up -d

cd /opt/my-site
docker compose up -d