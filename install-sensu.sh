#!/bin/bash
apt-get install redis-server

wget -q http://repos.sensuapp.org/apt/pubkey.gpg -O- | apt-key add -
echo "deb     http://repos.sensuapp.org/apt sensu main" > /etc/apt/sources.list.d/sensu.list

apt-get update
apt-get install sensu

git clone https://github.com/joemiller/joemiller.me-intro-to-sensu.git /tmp/sensu-certs
cd /tmp/sensu-certs/
./ssl_certs.sh clean
./ssl_certs.sh generate
mkdir /etc/sensu/ssl/
cp client_key.pem /etc/sensu/ssl/
cp client_cert.pem /etc/sensu/ssl/

chown -R sensu:sensu /etc/sensu/
