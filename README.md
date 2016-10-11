# diamond-DockerContainerCollector
A diamond collector for docker containers

A docker container that will ship the host and container metrics to graphite.

Diamond collectors are modified to read host stats from /host_proc instead of proc.
The DockerContainerCollector uses docker-py to gather container metrics.

If you wish you test it out, a container is available on the docker hub: https://registry.hub.docker.com/u/lesaux/diamond-containercollector/

The following environment variables are being used to launch the container:
```
STATSD_HOST=the ip address of your StatsD daemon.
STATSD_PORT=the port StatsD listens on.
DOCKER_HOSTNAME=the name of the docker host as you wish to see it in graphite.
```
The docker hosts metrics will be in the servers.hostname graphite path.
The container metrics will be in the docker.hostname.containers graphite path.

```
docker run -i -e STASTD_HOST=192.168.0.78 -e STATSD_PORT=8125 -e DOCKER_HOSTNAME=docker-node1 -v /proc:/host_proc:ro -v /var/run/docker.sock:/var/run/docker.sock:ro lesaux/diamond-containercollector
```

I found that in more recent docker versions (with docker-machine and boot2docker) you need to mount
```
-v /dev:/dev:ro
```
as well to monitor boot2docker-data disk space usage.
