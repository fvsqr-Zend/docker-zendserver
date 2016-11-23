#!/bin/bash

source /etc/zs_env

zsclient \
  --zskey="$WEB_API_KEY" \
  --zssecret="$WEB_API_SECRET" \
  --zsurl="http://$ZENDSERVER_HOST:10081"\
  \
  getSystemInfo \
    --output-format=json \
    | jq '.'

zsclient \
  --zskey="$WEB_API_KEY" \
  --zssecret="$WEB_API_SECRET" \
  --zsurl="http://$ZENDSERVER_HOST:10081"\
  \
  clusterGetServerStatus \
    --output-format=json \
    | jq '.'

zsclient \
  --zskey="$WEB_API_KEY" \
  --zssecret="$WEB_API_SECRET" \
  --zsurl="http://$ZENDSERVER_HOST:10081"\
  \
  applicationGetStatus \
    --output-format=json \
    | jq '.'
