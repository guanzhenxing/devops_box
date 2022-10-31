#!/bin/sh

# 暗装docker
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh --mirror Aliyun
# sudo sh get-docker.sh --mirror AzureChinaCloud

# 启动docker
sudo systemctl enable docker
sudo systemctl start docker

# 安装 docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
