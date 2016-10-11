FROM alpine:3.4
MAINTAINER Jaimal Chohan <jaimal.chohan@just-eat.com>

ENV STATSD_HOST 127.0.0.1
ENV STATSD_PORT 8125
ENV DOCKER_HOSTNAME docker-hostname

RUN apk add --no-cache build-base linux-headers python-dev py-pip \
  && pip install diamond docker-py statsd \
  && rm -rf /var/cache/apk/*

COPY diamond /etc/diamond/

COPY config_diamond.sh entrypoint.sh /
RUN chmod +x /config_diamond.sh \
  && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
