#!/bin/bash
apt-get install redis-server

wget -q http://repos.sensuapp.org/apt/pubkey.gpg -O- | apt-key add -
echo "deb     http://repos.sensuapp.org/apt sensu main" > /etc/apt/sources.list.d/sensu.list

apt-get update
apt-get install sensu

chown -R sensu:sensu /etc/sensu/
