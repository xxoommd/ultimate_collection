sudo docker run -dt --restart always --name ssserver -p 9527:6443 -p 19527:6500/udp mritd/shadowsocks -m "ss-server" -s "-s 0.0.0.0 -p 6443 -m chacha20 -k fuckyouall" -x -e "kcpserver" -k "-t 127.0.0.1:6443 -l :6500 -mode fast2 -key alwaysfuck -crypt xtea -nocomp"
