#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
UNDERLINE='\033[4m' # 下划线
NC='\033[0m'        # No Color


if [ -z $1 ]; then
  echo -e "[${RED}ERR${NC}] Should provide at least 1 argument"
  exit 1
fi

DEPLOY_DOMAIN=$1

is_valid_domain() {
  local str="$1"
  
  # 使用正则表达式匹配合法域名格式
  if [[ $str =~ ^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z]{2,})+$ ]]; then
    return 0  # 合法返回0
  else
    return 1  # 不合法返回1
  fi
}

echo

if is_valid_domain "$DEPLOY_DOMAIN"; then
  echo -e "[INFO] ${BLUE}${UNDERLINE}$DEPLOY_DOMAIN${NC} is a valid domain."
  echo -e "[INFO] Generating ${GREEN}Caddyfile${NC} ..."
else
  echo -e "[${RED}ERR${NC}] ${BLUE}${UNDERLINE}$DEPLOY_DOMAIN${NC} is not a valid domain. Abort."
  exit 1
fi

CADDY_STORAGE="/root/caddy_data"

CERT_DIR="$CADDY_STORAGE/certificates/acme-v02.api.letsencrypt.org-directory/$DEPLOY_DOMAIN"
CRT_FILE="$CERT_DIR/$DEPLOY_DOMAIN.crt"
KEY_FILE="$CERT_DIR/$DEPLOY_DOMAIN.key"

cat > Caddyfile << EOF
{
	storage file_system $CADDY_STORAGE
}

:443, ${DEPLOY_DOMAIN}
tls xxoommd@${DEPLOY_DOMAIN}
	route {
		forward_proxy {
		basic_auth xxoommd fuckyouall
		hide_ip
		hide_via
		probe_resistance
		# upstream socks5://127.0.0.1:40000
	}
		respond "hello ${DEPLOY_DOMAIN}@naive!"
}
EOF

echo -e "[INFO] Generate ${GREEN}Caddyfile${NC} success."
echo -e "[INFO] Generating ${GREEN}config.json${NC} ..."

cat > config.yaml << EOF
listen: :8443
tls:
  cert: $CRT_FILE
  key: $KEY_FILE
auth:
  type: password
  password: fuckyouall
masquerade:
  type: string
  string:
    content: 'hello ${DEPLOY_DOMAIN}@hysteria2'
    headers:
      content-type: text/plain
      custom-stuff: ice cream so good
    statusCode: 200
disableUDP: false
EOF

echo -e "[INFO] Generate ${GREEN}config.yaml${NC} success."
echo
