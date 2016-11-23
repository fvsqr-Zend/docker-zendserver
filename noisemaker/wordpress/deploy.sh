#!/bin/bash

source /etc/wp_credentials
source /etc/zs_env

zsclient installApp \
  --zpk=/zpk/wordpress.zpk \
  --zskey=$WEB_API_KEY \
  --zssecret=$WEB_API_SECRET \
  --zsurl=http://$ZENDSERVER_HOST:10081/ZendServer \
  --baseUri=$WP_BASE_URI \
  --userParams="site_url=$WP_SITE_URL&db_host=$WP_DB_HOST&db_username=$WP_DB_USER&db_password=$WP_DB_PASS&db_name=$WP_DB_NAME&admin_password=$WP_ADMIN_PASSWORD"
