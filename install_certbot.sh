#!/bin/bash

apt-get update
apt-get install -y software-properties-common
add-apt-repository universe
add-apt-repository ppa:certbot/certbot
apt-get update
apt-get install -y certbot python-certbot-nginx 
