#
# balance
#

FROM ubuntu:trusty
MAINTAINER Jan Burkl <jan@zend.com>

RUN apt-get update && apt-get install -y balance php5-cli && apt-get install -y inotify-tools

ADD run.sh /run.sh
RUN chmod 775 /*.sh

ADD balance_conf.php /balance_conf.php
RUN chmod 775 /*.php

CMD ["/run.sh"]
