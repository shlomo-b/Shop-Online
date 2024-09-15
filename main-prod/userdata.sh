#!/bin/bash

yum update -y
yum install -y docker
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# pull and run he most recent image from docker hub.
# docker pull shlomobarzili/blackjack:$(curl -s https://hub.docker.com/v2/repositories/shlomobarzili/blackjack/tags/?page_size=1 | grep -oP '"name":\s*"\K[^"]+')
# docker run -d -p 80:80 shlomobarzili/blackjack:$(curl -s https://hub.docker.com/v2/repositories/shlomobarzili/blackjack/tags/?page_size=1 | grep -oP '"name":\s*"\K[^"]+')

docker pull shlomobarzili/blackjack:latest
docker run -d -p 80:80 --name full-ci-cd-blackjack shlomobarzili/blackjack:latest