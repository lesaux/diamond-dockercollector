# Docker image containing the Diamond collector
#
# VERSION               0.0.1
FROM      ubuntu:16.04
MAINTAINER Jaimal Chohan <jaimal.chohan@just-eat.com>

# Install dependencies
ENV DEBIAN_FRONTEND noninteractive
ENV STATSD_HOST 127.0.0.1
ENV STATSD_PORT 8125
ENV DOCKER_HOSTNAME docker-hostname

RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y python-pip && \
    pip install statsd diamond docker-py && \
    mkdir /usr/local/share/diamond/collectors/dockercontainer && \
    find /usr/local/share/diamond/collectors/  -type f -name "*.py" -print0 | xargs -0 sed -i 's/\/proc/\/host_proc/g' && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /Diamond /diamond-DockerContainerCollector /docker-py && \
    rm -rf /etc/diamond

#add diamond config dir
ADD diamond /etc/diamond/

#add docker container collector
ADD dockercontainer.py /usr/local/share/diamond/collectors/dockercontainer/

#startup script
ADD config_diamond.sh /config_diamond.sh
RUN chmod +x /config_diamond.sh

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

#start
ENTRYPOINT ["/entrypoint.sh"]
