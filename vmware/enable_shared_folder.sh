#!/bin/sh

sudo cp mnt-hgfs.mount /etc/systemd/system/ && \
sudo cp open-vm-tools.conf /etc/modules-load.d/ && \
sudo systemctl enable mnt-hgfs.mount && \
sudo modprobe -v fuse && \
sudo systemctl start mnt-hgfs.mount