#!/bin/bash
apt-get install redis-server

wget -q http://repos.sensuapp.org/apt/pubkey.gpg -O- | apt-key add -
echo "deb     http://repos.sensuapp.org/apt sensu main" > /etc/apt/sources.list.d/sensu.list

apt-get update
apt-get install sensu

mkdir /etc/sensu/ssl/
cd /tmp/sensu-certs/
cp client_key.pem /etc/sensu/ssl/
cp client_cert.pem /etc/sensu/ssl/

chown -R sensu:sensu /etc/sensu/
