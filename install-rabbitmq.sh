#!/bin/bash
#mkdir /etc/rabbitmq/ssl
#cp server_key.pem /etc/rabbitmq/ssl/
#cp server_cert.pem /etc/rabbitmq/ssl/
#cp testca/cacert.pem /etc/rabbitmq/ssl/

apt-get -y install erlang-nox
echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list

curl -L -o ~/rabbitmq-signing-key-public.asc http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key add ~/rabbitmq-signing-key-public.asc

apt-get update
apt-get -y --allow-unauthenticated --force-yes install rabbitmq-server

rabbitmq-plugins enable rabbitmq_management
rabbitmq-server -detached
