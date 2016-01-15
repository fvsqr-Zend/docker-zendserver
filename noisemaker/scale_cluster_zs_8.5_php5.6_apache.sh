#!/bin/bash

echo "Scaling to $1 nodes"

docker-compose -f ../ZendServer-8.5/php5.6/apache/docker-compose.yml -p phpcluster scale zendserver=$1
