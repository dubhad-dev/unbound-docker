#!/bin/sh

wget -N https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts

cat hosts | grep '^0\.0\.0\.0' | awk '{print "local-zone: \""$2"\" redirect\nlocal-data: \""$2" A 0.0.0.0\""}' > conf/blocklist-StevenBlack.conf

rm hosts