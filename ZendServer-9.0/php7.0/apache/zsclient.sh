#!/bin/bash

/usr/local/zend/bin/php /zsclient --zskey=docker --zssecret=$(cat /webapi/secret) --zsurl=http://zendserver:10081 $1