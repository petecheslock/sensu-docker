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
RUN git clone git://github.com/joemiller/joemiller.me-intro-to-sensu.git ~/sensu-certs/
RUN cd ~/sensu-certs/
RUN ./ssl_certs.sh clean
RUN ./ssl_certs.sh generate

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

