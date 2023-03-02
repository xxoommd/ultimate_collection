# Installation Guide

## 1. Config ip for your domain, e.g., np.xxx.com, then set up as a variable.
```
export DEPLOY_DOMAIN=np.xxx.com
```
## 2. Installing.
```
wget "https://go.dev/dl/$(curl https://go.dev/VERSION?m=text).linux-amd64.tar.gz" && \
tar -xf go*.linux-amd64.tar.gz -C /usr/local/ && \
echo 'export GOROOT=/usr/local/go' >> /etc/profile && \
echo 'export PATH=$GOROOT/bin:$PATH' >> /etc/profile && \
source /etc/profile && \
export GO111MODULE=on && \
go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest && \
~/go/bin/xcaddy build --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive && \
echo ":443, ${DEPLOY_DOMAIN}
  tls xxoommd@${DEPLOY_DOMAIN}
  route {
   forward_proxy {
     basic_auth xxoommd fuckyouall #用户名和密码
     hide_ip
     hide_via
     probe_resistance
    }
   respond / "hello world!"
  }" > Caddyfile && \
./cadd start

```
