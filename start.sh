#!/bin/bash
/etc/init.d/rabbitmq-server start
rabbitmqctl add_vhost /sensu
rabbitmqctl add_user sensu mypass
rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"
rabbitmqctl set_user_tags sensu administrator

/etc/init.d/redis-server start
/etc/init.d/sensu-server start
/etc/init.d/sensu-api start
/etc/init.d/sensu-client start
/etc/init.d/sensu-dashboard start
/usr/bin/sshd -D -o UseDNS=no -o UsePAM=no
