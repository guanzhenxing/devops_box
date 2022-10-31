#!/bin/sh

# 暗装docker
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh --mirror Aliyun
# sudo sh get-docker.sh --mirror AzureChinaCloud

# 启动docker
sudo systemctl enable docker
sudo systemctl start docker
