#!/bin/bash
set -e

echo "=> Configuring Diamond"
sed -i \
    -e "s/<--STATSD_HOST-->/${STATSD_HOST}/g" \
    -e "s/<--STATSD_PORT-->/${STATSD_PORT}/g" \
    -e "s/<--PREFIX-->/${PREFIX}/g" \
    -e "s/<--SUFFIX-->/${SUFFIX}/g" \
    -e "s/<--DOCKER_HOSTNAME-->/${DOCKER_HOSTNAME}/g" \
    /etc/diamond/diamond.conf


echo "=> Done!"
