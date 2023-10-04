# Installation Guide

## 1. Config ip for your domain, e.g., np.xxx.com, then set up as a variable.
```
export DEPLOY_DOMAIN=np.xxx.com
```
## 2. Installing.
```
export hn=`hostname`
export DEPLOY_DOMAIN=${hn}.projectx.top
wget "https://go.dev/dl/$(curl https://go.dev/VERSION?m=text|grep go).linux-amd64.tar.gz" && \
tar -xf go*.linux-amd64.tar.gz -C /usr/local/ && \
echo 'export GOROOT=/usr/local/go' >> /etc/profile && \
echo 'export PATH=$GOROOT/bin:$PATH' >> /etc/profile && \
source /etc/profile && \
echo "# max open files
fs.file-max = 51200
net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.core.rmem_default = 65536
net.core.wmem_default = 65536
net.core.netdev_max_backlog = 4096
net.core.somaxconn = 4096
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.ip_local_port_range = 10000 65000
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864
net.ipv4.tcp_mtu_probing = 1
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control = bbr" > /etc/sysctl.conf && \
sysctl -p && \
export GO111MODULE=on && \
go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest && \
~/go/bin/xcaddy build --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive

echo ":443, ${DEPLOY_DOMAIN}
tls xxoommd@${DEPLOY_DOMAIN}
  route {
    forward_proxy {
    basic_auth xxoommd fuckyouall
    hide_ip
    hide_via
    probe_resistance
  }
  respond ${DEPLOY_DOMAIN}!
}" > Caddyfile && \
./caddy start

```
