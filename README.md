sensu-docker
============

Dockerfile to Create a Sensu Server

This is for testing only - SSL is not setup/configured for the server and clients.

Port `15672` is where the rabbitmq management dashboard is running on
When you run container you can see which port the Sensu dashboard is listening on my running `docker ps`

```
docker@ubuntu:~$ docker ps
ID                  IMAGE                         COMMAND             CREATED             STATUS              PORTS
cc88c90d715e        petecheslock/sensu:0.10.2-1   /bin/bash           5 minutes ago       Up 5 minutes        15672->15672, 49158->8080
```

