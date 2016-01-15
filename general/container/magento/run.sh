#!/bin/bash

./zs-client.phar installApp \
  --zpk=/magento.zpk \
  --zskey=docker \
  --zssecret=$WEB_API_SECRET \
  --zsurl=http://ZENDSERVER:10081/ZendServer \
  --baseUri="/" \
  --userParams="site_url=http://localhost:8080&db_host=DB&db_username=admin&db_password=$DB_ENV_MYSQL_PASS&db_name=magento&admin_password=admin"
