#!/bin/bash
RUN git clone https://github.com/joemiller/joemiller.me-intro-to-sensu.git ~/sensu-certs/
RUN ~/sensu-certs/ssl_certs.sh clean
RUN ~/sensu-certs/ssl_certs.sh generate

RUN mkdir /etc/rabbitmq/ssl
RUN cp server_key.pem /etc/rabbitmq/ssl/
RUN cp server_cert.pem /etc/rabbitmq/ssl/
RUN cp testca/cacert.pem /etc/rabbitmq/ssl/

RUN apt-get -y install erlang-nox
RUN echo "deb http://www.rabbitmq.com/debian/ testing main"
RUN >/etc/apt/sources.list.d/rabbitmq.list

RUN curl -L -o ~/rabbitmq-signing-key-public.asc http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
RUN apt-key add ~/rabbitmq-signing-key-public.asc

RUN apt-get update
RUN apt-get -y --allow-unauthenticated --force-yes install rabbitmq-server

ADD rabbitmq.config /etc/rabbitmq/rabbitmq.config

update-rc.d rabbitmq-server defaults
/etc/init.d/rabbitmq-server start

rabbitmqctl add_vhost /sensu
rabbitmqctl add_user sensu mypass
rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"

