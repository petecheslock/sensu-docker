#!/bin/bash
git clone https://github.com/joemiller/joemiller.me-intro-to-sensu.git /tmp/sensu-certs
cd /tmp/sensu-certs/
./ssl_certs.sh clean
./ssl_certs.sh generate

mkdir /etc/rabbitmq/ssl
cp server_key.pem /etc/rabbitmq/ssl/
cp server_cert.pem /etc/rabbitmq/ssl/
cp testca/cacert.pem /etc/rabbitmq/ssl/

apt-get -y install erlang-nox
echo "deb http://www.rabbitmq.com/debian/ testing main"
>/etc/apt/sources.list.d/rabbitmq.list

curl -L -o ~/rabbitmq-signing-key-public.asc http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key add ~/rabbitmq-signing-key-public.asc

apt-get update
apt-get -y --allow-unauthenticated --force-yes install rabbitmq-server

rabbitmq.config /etc/rabbitmq/rabbitmq.config

rabbitmqctl add_vhost /sensu
rabbitmqctl add_user sensu mypass
rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"

