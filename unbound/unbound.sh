#!/bin/bash

mkdir -p -m 700 /usr/local/etc/unbound/var && \
chown _unbound:_unbound /usr/local/etc/unbound/var && \
/usr/local/sbin/unbound-anchor -a /usr/local/etc/unbound/var/root.key

exec /usr/local/sbin/unbound