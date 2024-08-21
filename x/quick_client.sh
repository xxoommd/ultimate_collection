#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
UNDERLINE='\033[4m' # 下划线
NC='\033[0m'        # No Color

BIN_PATH="."

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	echo "Linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	echo "macOS"
elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin"* ]]; then
	echo "Git Bash on Windows"
else
	echo -e "[${RED}ERR${NC}] Unsupported OS: ${YELLOW}${OSTYPE}${NC}"
	exit 1
fi

function download_hysteria() {

}

function download_caddy() {

}

function gen_hy_config() {

}

function gen_caddy_config() {

}

echo -e "[INFO] Download ${GREEN}hysteria${NC} and ${GREEN}caddy${NC} ..." &&
	curl -L -o ${BIN_PATH}/hysteria https://github.com/xxoommd/ultimate_collection/releases/download/latest/hysteria &&
	curl -L -o ${BIN_PATH}/caddy https://github.com/xxoommd/ultimate_collection/releases/download/latest/caddy &&
	chmod +x $BIN_PATH/hysteria $BIN_PATH/caddy &&
	echo -e "[INFO] Download Done\n"
