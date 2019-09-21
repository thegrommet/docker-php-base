#!/bin/sh -ex

/sbin/syslogd -O /proc/1/fd/1
/usr/sbin/haproxy -db -f /etc/haproxy/haproxy.cfg
