#!/bin/bash

source /etc/zs_env

ZENDSERVER_IP=$(getent hosts $ZENDSERVER_HOST | awk '{ print $1 }')

zsclient \
  --zskey="$WEB_API_KEY" \
  --zssecret="$WEB_API_SECRET" \
  --zsurl="http://$ZENDSERVER_HOST:10081"\
  \
  monitorGetIssuesByPredefinedFilter \
    --filterId="Performance Issues" \
    --limit=100 \
    --offset=0 \
    --order=date \
    --direction=DESC \
    \
      --output-format=json \
      | jq '.'
