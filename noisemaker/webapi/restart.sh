#!/bin/bash

source /etc/zs_env

zsclient \
  --zskey="$WEB_API_KEY" \
  --zssecret="$WEB_API_SECRET" \
  --zsurl="http://$ZENDSERVER_HOST:10081"\
  \
  restartPhp \
    --output-format=json \
    | jq '.'
