#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
UNDERLINE='\033[4m' # 下划线
NC='\033[0m'        # No Color

if [[ -z $DOMAIN_NAME ]]; then
  echo
  echo "[${RED}Err${NC}]DOMAIN_NAME is not set"
  echo
  exit 1
fi

apt update && apt install -y net-tools &&
  curl -L https://github.com/xxoommd/ultimate_collection/archive/refs/tags/latest.tar.gz | tar -xz -C ~ &&
  cd ~/ultimate_collection-latest/mixed && ./generate_config_files.sh $DOMAIN_NAME && ./caddy start &&
  sleep 10 &&
  nohup ./hysteria server & && \
  ps aux|grep caddy && ps aux|grep hysteria && netstat -ano|grep 443
