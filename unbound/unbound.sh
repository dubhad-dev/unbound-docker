#!/bin/bash

mkdir -p /usr/local/etc/unbound/dev && \
cp -a /dev/random /dev/urandom /dev/null /usr/local/etc/unbound/dev/

mkdir -p -m 700 /usr/local/etc/unbound/var && \
chown _unbound:_unbound /usr/local/etc/unbound/var && \
/usr/local/sbin/unbound-anchor -a /usr/local/etc/unbound/var/root.key

exec /usr/local/sbin/unbound -d -c /usr/local/etc/unbound/unbound.conf