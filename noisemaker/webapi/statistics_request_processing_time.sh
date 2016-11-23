#!/bin/bash

source /etc/zs_env

ZENDSERVER_IP=$(getent hosts $ZENDSERVER_HOST | awk '{ print $1 }')

zsclient \
  --zskey="$WEB_API_KEY" \
  --zssecret="$WEB_API_SECRET" \
  --zsurl="http://$ZENDSERVER_HOST:10081"\
  \
  statisticsGetSeries \
    --type="AVG_REQUEST_PROCESSING_TIME" \
    \
      --output-format=json \
      | jq '.'

zsclient \
  --zskey="$WEB_API_KEY" \
  --zssecret="$WEB_API_SECRET" \
  --zsurl="http://$ZENDSERVER_HOST:10081"\
  \
  statisticsGetSeries \
    --type="MAX_REQUEST_PROCESSING_TIME" \
    \
      --output-format=json \
      | jq '.'

zsclient \
  --zskey="$WEB_API_KEY" \
  --zssecret="$WEB_API_SECRET" \
  --zsurl="http://$ZENDSERVER_HOST:10081"\
  \
  statisticsGetSeries \
    --type="MIN_REQUEST_PROCESSING_TIME" \
    \
      --output-format=json \
      | jq '.'
