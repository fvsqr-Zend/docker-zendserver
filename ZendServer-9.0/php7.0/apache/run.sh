#!/bin/bash

source /shell_functions.rc

trap "remove_from_cluster; exit" SIGINT SIGTERM SIGHUP

print_header

echo ServerName $HOSTNAME >> /etc/apache2/apache2.conf

service zend-server start

if [[ -n $CLUSTER ]]; then
  add_to_cluster
fi

print_header

exec tail -f /usr/local/zend/var/log/*.log & wait
