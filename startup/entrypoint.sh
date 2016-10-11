#!/bin/sh

/config_diamond.sh
diamond -f --skip-pidfile -c /etc/diamond/diamond.conf
