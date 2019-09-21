#!/bin/sh

varnishd -s malloc,${VARNISH_MEMORY} -a :${VARNISH_PORT} -f /etc/varnish/default.vcl -p http_resp_hdr_len=131072 -p feature=+esi_disable_xml_check
sleep 1
varnishlog
