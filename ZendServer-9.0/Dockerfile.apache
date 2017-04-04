#
# Zend Server 9.0
#

FROM ubuntu:16.04
LABEL maintainer "jan.burkl@roguewave.com"

ARG PHP_VERSION=7.0
ARG ZS_INSTALL_ARGS=--automatic

ADD ZendServer-RepositoryInstaller-linux /ZendServer-RepositoryInstaller-linux

RUN chmod 775 /ZendServer-RepositoryInstaller-linux/*.sh
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y wget && wget http://repos.zend.com/zend.key -O- |apt-key add - \
  && /ZendServer-RepositoryInstaller-linux/install_zs.sh ${PHP_VERSION} ${ZS_INSTALL_ARGS} \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /webapi && date +%s | sha256sum | base64 | head -c 64 | sed 's/.*/\L&/' > /webapi/secret
RUN echo "Setting Docker API key and bootstrapping Zend Server" && \
WEB_API_SECRET=$(cat /webapi/secret) && \
/usr/local/zend/bin/zendctl.sh start && \
/usr/local/zend/bin/zs-manage api-keys-add-key -n docker -s $WEB_API_SECRET && \
/usr/local/zend/bin/zs-manage bootstrap-single-server -p admin -a 'TRUE' -r FALSE -t 3 -w 5 && \
/usr/local/zend/bin/zs-manage restart -N docker -K $WEB_API_SECRET && \
/usr/local/zend/bin/zendctl.sh stop

COPY run.sh /run.sh
RUN chmod 775 /*.sh

COPY shell_functions.rc /shell_functions.rc
RUN rm -f /usr/local/zend/var/log/*.log

RUN echo export APACHE_ULIMIT_MAX_FILES=\"ulimit -n 4096\" >> /etc/zce.rc

EXPOSE 80
EXPOSE 443
EXPOSE 10081
EXPOSE 10082

CMD ["/run.sh"]
