sensu-docker
============

Dockerfile to Create a Sensu Server

Grab the container from the docker index here.  https://index.docker.io/u/petecheslock/sensu/

This is for testing only - SSL is not setup/configured for the server and clients.

Port `15672` is where the rabbitmq management dashboard is running on (`un: sensu pw: mypass`)
When you run container you can see which port the Sensu dashboard is listening on my running `docker ps` (`un: admin pw: secret`)

```
docker@ubuntu:~$ docker ps
ID                  IMAGE                         COMMAND             CREATED             STATUS              PORTS
cc88c90d715e        petecheslock/sensu:0.10.2-1   /bin/bash           5 minutes ago       Up 5 minutes        15672->15672, 49158->8080
```

By default - when starting the container, docker will start all the necessary services and start sshd.

Run `docker ps` to get the container ID

Then run `docker inspect ${container ID}` to get the IP address of the container to connect to.

From there you can SSH to the container to inspect the running sensu processes. (`un: sensu pw: sensu`)
