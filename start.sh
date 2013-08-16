#!/bin/bash
#Need this for rabbitmq to start
echo  "127.0.0.1 $HOSTNAME" >> /etc/hosts

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
/usr/sbin/sshd -D -o UseDNS=no -o UsePAM=no
