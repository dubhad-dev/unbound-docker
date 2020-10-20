#!/bin/bash

mkdir -p /usr/local/etc/unbound/dev && \
cp -a /dev/random /dev/urandom /dev/null /usr/local/etc/unbound/dev/

/usr/local/sbin/unbound-anchor -a /usr/local/etc/unbound/root.key

exec /usr/local/sbin/unbound 