#
# Zend Server 8.5
#

FROM ubuntu:trusty
MAINTAINER Jan Burkl <jan@zend.com>

RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget php5-cli
RUN wget https://github.com/zend-patterns/ZendServerSDK/raw/master/bin/zs-client.phar && chmod 755 zs-client.phar
RUN wget "http://updates.zend.com/zpkai/index.php?name=Magento&version=&name=Magento&version=" -O magento.zpk

ADD run.sh /run.sh
RUN chmod 775 /*.sh

CMD ["/run.sh"]
