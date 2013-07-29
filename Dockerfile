FROM ubuntu:precise
MAINTAINER Pete Cheslock <petecheslock@gmail.com>

RUN apt-get install -y sudo openssh-server curl lsb-release git
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
RUN mkdir -p /var/run/sshd
RUN echo '127.0.0.1 localhost.localdomain localhost' >> /etc/hosts
RUN useradd -d /home/sensu -m -s /bin/bash sensu
RUN echo sensu:sensu | chpasswd
RUN echo 'sensu ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/sensu

ADD policy-rc.d /usr/sbin/policy-rc.d
ADD rabbitmq.config /etc/rabbitmq/rabbitmq.config

ADD install-rabbitmq.sh /tmp/
RUN /tmp/install-rabbitmq.sh

CMD /etc/init.d/rabbitmq-server start
CMD rabbitmqctl add_vhost /sensu
CMD rabbitmqctl add_user sensu mypass
CMD rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"
