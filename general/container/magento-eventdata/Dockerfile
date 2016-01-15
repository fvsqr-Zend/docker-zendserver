#
# Zend Server 8.5
#

FROM ubuntu:trusty
MAINTAINER Jan Burkl <jan@zend.com>

RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-client

ADD run.sh /run.sh
ADD update_table.sh /update_table.sh
RUN chmod 775 /*.sh

ADD eventdata.sql /eventdata.sql
ADD eventdata-timestamp.sql /eventdata-timestamp.sql

CMD ["/run.sh"]
