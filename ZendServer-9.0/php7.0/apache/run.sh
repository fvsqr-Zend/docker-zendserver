#!/bin/bash

shutdown_zs()
{
    echo "Removing server from cluster..."
    WEB_API_SECRET=$(cat /root/web_api_secret)
    SERVER_ID=`$ZS_MANAGE cluster-list-servers -N docker -K $WEB_API_SECRET | grep $HOSTNAME | cut -f1`
    $ZS_MANAGE cluster-remove-server $SERVER_ID -N docker -K $WEB_API_SECRET -s
    exit 0
}

trap "shutdown_zs; exit" SIGINT SIGTERM SIGHUP

ZS_MANAGE=/usr/local/zend/bin/zs-manage
HOSTNAME=`hostname`
APP_UNIQUE_NAME=$HOSTNAME
APP_IP=`/sbin/ifconfig eth0| grep 'inet addr:' | awk {'print $2'}| cut -d ':' -f 2`

service zend-server start

if [[ -n $ZS_ADMIN_PASSWORD ]]; then
  echo "Changing GUI Password" 
  /usr/local/zend/bin/php /usr/local/zend/bin/gui_passwd.php $ZS_ADMIN_PASSWORD 
fi 

WEB_API_SECRET=$(cat /root/web_api_secret)

if [[ -n $CLUSTER ]]; then
  echo "Joining cluster"
  $ZS_MANAGE server-add-to-cluster -T 120 -n $APP_UNIQUE_NAME -i $APP_IP -o DB:3306 -u admin -p admin -d ZendServer -N docker -K $WEB_API_SECRET -s
  $ZS_MANAGE store-directive -d 'session.save_handler' -v 'cluster' -N docker -K $WEB_API_SECRET
fi

$ZS_MANAGE store-directive -d 'zray.zendserver_ui_url' -v "http://$APP_IP:10081/ZendServer" -N docker -K $WEB_API_SECRET
$ZS_MANAGE restart -N docker -K $WEB_API_SECRET

echo "********************************************

Zend Server is ready for use
Your application is available at http://$APP_IP
To access Zend Server, navigate to http://$APP_IP:10081"

echo "
********************************************"

tail -f /var/log/dpkg.log > /dev/null &
wait
