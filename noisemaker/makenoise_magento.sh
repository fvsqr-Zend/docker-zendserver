#!/bin/bash

docker build -t janatzend/noisemaker/magento-eventdata ../general/container/magento-eventdata

if [ "$1" != "update" ]; then
    docker build -t janatzend/noisemaker/magento ../general/container/magento
    docker run \
        -e WEB_API_SECRET=$(docker exec phpcluster_zendserver_1 bash -c "cat /root/web_api_secret") \
        --link phpcluster_zendserver_1:zendserver \
        --link phpcluster_mysql_1:db \
        janatzend/noisemaker/magento
fi

docker run \
  --link phpcluster_mysql_1:db \
  janatzend/noisemaker/magento-eventdata
