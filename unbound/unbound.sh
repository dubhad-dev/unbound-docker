#!/bin/bash

/usr/local/sbin/unbound-anchor -a /usr/local/etc/unbound/root.key

exec /usr/local/sbin/unbound