#!/bin/bash

source /etc/magento_credentials
source /etc/zs_env

zsclient installApp \
  --zpk=/zpk/magento.zpk \
  --zskey=$WEB_API_KEY \
  --zssecret=$WEB_API_SECRET \
  --zsurl=http://$ZENDSERVER_HOST:10081/ZendServer \
  --baseUri=$MAGENTO_BASE_URI \
  --userParams="site_url=$MAGENTO_SITE_URL&db_host=$MAGENTO_DB_HOST&db_username=$MAGENTO_DB_USER&db_password=$MAGENTO_DB_PASS&db_name=$MAGENTO_DB_NAME&admin_password=$MAGENTO_ADMIN_PASSWORD"
