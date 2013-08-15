#!/bin/bash
git clone https://github.com/joemiller/joemiller.me-intro-to-sensu.git /tmp/sensu-certs
cd /tmp/sensu-certs/
./ssl_certs.sh clean
./ssl_certs.sh generate

mkdir /etc/rabbitmq/ssl
cp server_key.pem /etc/rabbitmq/ssl/
cp server_cert.pem /etc/rabbitmq/ssl/
cp testca/cacert.pem /etc/rabbitmq/ssl/

/etc/init.d/rabbitmq-server start
rabbitmqctl add_vhost /sensu
rabbitmqctl add_user sensu mypass
rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"
rabbitmqctl set_user_tags sensu administrator

mkdir /etc/sensu/ssl/
cd /tmp/sensu-certs/
cp client_key.pem /etc/sensu/ssl/
cp client_cert.pem /etc/sensu/ssl/

/etc/init.d/redis-server start
/etc/init.d/sensu-server start
/etc/init.d/sensu-api start
/etc/init.d/sensu-client start
/opt/sensu/embedded/bin/ruby /opt/sensu/bin/sensu-dashboard -c /etc/sensu/config.json -d /etc/sensu/conf.d -e /etc/sensu/extensions -p /var/run/sensu/sensu-dashboard.pid -l /var/log/sensu/sensu-dashboard.log
