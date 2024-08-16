#!/bin/bash

apt update && apt install -y net-tools &&
  curl -L https://github.com/xxoommd/ultimate_collection/archive/refs/tags/latest.tar.gz | tar -xz ~ &&
  cd ~/ultimate_collection_latest/mixed && ./generate_config_files.sh $DOMAIN_NAME && ./caddy start &&
  sleep 10 &&
  nohup ./hysteria server &
