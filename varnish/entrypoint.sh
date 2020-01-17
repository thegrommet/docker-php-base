#!/bin/sh

_VARNISH_PARAMS="\
  -s malloc,${VARNISH_MEMORY} \
  -a :${VARNISH_PORT} \
  -f /etc/varnish/default.vcl \
  -p http_resp_hdr_len=131072 \
  -p http_resp_size=163840 \
  -p workspace_backend=163840 \
  -p feature=+http2 \
"

if [ $VARNISHLOG_ENABLED != 1 ]; then _VARNISH_PARAMS="-F $_VARNISH_PARAMS"; fi

varnishd $_VARNISH_PARAMS

if [ $VARNISHLOG_ENABLED == 1 ]; then
  sleep 1
  varnishlog -x Debug -x Link
fi
