#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
UNDERLINE='\033[4m' # 下划线
NC='\033[0m'        # No Color

echo
echo -e "[INFO] Updating ${GREEN}caddy${NC} ..."

wget "https://go.dev/dl/$(curl https://go.dev/VERSION?m=text | grep go).linux-amd64.tar.gz" &&
  tar -xf go*.linux-amd64.tar.gz -C /usr/local/ &&
  echo 'export GOROOT=/usr/local/go' >>/etc/profile &&
  echo 'export PATH=$GOROOT/bin:$PATH' >>/etc/profile &&
  echo 'export GO111MODULE=on' >>/etc/profile &&
  source /etc/profile &&
  go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest &&
  ~/go/bin/xcaddy build --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive

echo -e "[INFO] Updating ${GREEN}caddy${NC} success"

echo
echo -e "[INFO] Updating ${GREEN}hysteria2${NC} ..."
echo -e "[INFO] Updating ${GREEN}hysteria2${NC} success"
echo
