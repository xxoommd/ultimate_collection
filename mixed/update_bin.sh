#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
UNDERLINE='\033[4m' # 下划线
NC='\033[0m'        # No Color

function install_go() {
  wget "https://go.dev/dl/$(curl https://go.dev/VERSION?m=text | grep go).linux-amd64.tar.gz" &&
    sudo tar -xf go*.linux-amd64.tar.gz -C /usr/local/ &&
    rm go*.linux-amd64.tar.gz &&
    echo 'export GOROOT=/usr/local/go' >>~/.profile &&
    echo 'export PATH=$GOROOT/bin:$PATH' >>~/.profile &&
    echo 'export GO111MODULE=on' >>~/.profile &&
    source ~/.profile
}

if command -v go >/dev/null 2>&1; then
  echo "Go is installed"
  go version
else
  echo "Go is not installed"
  install_go

  if [[ $? != 0 ]]; then
    echo "Install go fail"
    exit 1
  fi
fi

function update_caddy() {
  go env -w GO111MODULE=on &&
    go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest &&
    ~/go/bin/xcaddy build --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive &&
    chmod +x ./caddy
}

function update_hysteria() {
  wget -O ./hysteria https://download.hysteria.network/app/latest/hysteria-linux-amd64-avx && chmod +x ./hysteria
}

echo
echo -e "[INFO] Updating ${GREEN}caddy${NC} ..."
if update_caddy; then
  echo -e "[INFO] Updating ${GREEN}caddy${NC} success"
else
  echo -e "[INFO] Updating ${GREEN}caddy${NC} fail"
  exit 1
fi
echo

echo -e "[INFO] Updating ${GREEN}hysteria2${NC} ..."
if update_hysteria; then
  echo -e "[INFO] Updating ${GREEN}hysteria2${NC} success"
else
  echo -e "[INFO] Updating ${GREEN}hysteria2${NC} fail"
  exit 1
fi
echo
