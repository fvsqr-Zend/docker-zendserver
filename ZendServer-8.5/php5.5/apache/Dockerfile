#
# Zend Server 8.5
#

FROM ubuntu:trusty
MAINTAINER Jan Burkl <jan@zend.com>

ADD ZendServer-RepositoryInstaller-linux /ZendServer-RepositoryInstaller-linux

RUN chmod 775 /ZendServer-RepositoryInstaller-linux/*.sh
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y supervisor wget && wget http://repos.zend.com/zend.key -O- |apt-key add -
RUN /ZendServer-RepositoryInstaller-linux/install_zs.sh 5.5 --automatic

RUN date +%s | sha256sum | base64 | head -c 64 | sed 's/.*/\L&/' > /root/web_api_secret
RUN echo "Setting Docker API key and bootstrapping Zend Server" && \
WEB_API_SECRET=$(cat /root/web_api_secret) && \
/usr/local/zend/bin/zendctl.sh start && \
/usr/local/zend/bin/zs-manage api-keys-add-key -n docker -s $WEB_API_SECRET && \
/usr/local/zend/bin/zs-manage bootstrap-single-server -p admin -a 'TRUE' -r FALSE -t 3 -w 5 && \
/usr/local/zend/bin/zs-manage restart -N docker -K $WEB_API_SECRET && \
/usr/local/zend/bin/zendctl.sh stop

ADD run.sh /run.sh
RUN chmod 775 /*.sh
ADD zend.conf /etc/supervisor/conf.d/zend.conf

EXPOSE 80
EXPOSE 443
EXPOSE 10081
EXPOSE 10082

CMD ["/run.sh"]
