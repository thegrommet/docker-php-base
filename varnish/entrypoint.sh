#!/bin/sh

varnishd -s malloc,${VARNISH_MEMORY} \
  -a :${VARNISH_PORT},PROXY \
  -f /etc/varnish/default.vcl \
  -p http_resp_hdr_len=131072 \
  -p http_resp_size=163840 \
  -p workspace_backend=163840 \
  -p feature=+http2
sleep 1
varnishlog
