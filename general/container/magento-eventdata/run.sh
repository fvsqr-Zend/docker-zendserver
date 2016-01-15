#!/bin/bash

function truncate_table {
    mysql -u admin -padmin -h db ZendServer -e "truncate table $1"
}

truncate_table events
truncate_table stats_daily
truncate_table stats_monthly
truncate_table stats_daily
truncate_table urlinsight_requests_daily
truncate_table urlinsight_requests_monthly
truncate_table urlinsight_requests_weekly

mysql -u admin -padmin -h db ZendServer < /eventdata.sql
mysql -u admin -padmin -h db ZendServer < /eventdata-timestamp.sql

/update_table.sh
