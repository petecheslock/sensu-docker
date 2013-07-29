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

ADD install-rabbitmq.sh /tmp/
RUN /tmp/install-rabbitmq.sh
