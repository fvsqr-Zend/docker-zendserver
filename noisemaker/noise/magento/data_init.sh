#!/bin/bash

source /etc/zs_env

function truncate_table {
    mysql -u $DB_USER -p$DB_PASS -h $DB_HOST $DB_NAME -e "truncate table $1"
}

truncate_table events
truncate_table stats_daily
truncate_table stats_monthly
truncate_table stats_daily
truncate_table urlinsight_requests_daily
truncate_table urlinsight_requests_monthly
truncate_table urlinsight_requests_weekly

mysql -u $DB_USER -p$DB_PASS -h $DB_HOST $DB_NAME < /sql/eventdata.sql
mysql -u $DB_USER -p$DB_PASS -h $DB_HOST $DB_NAME < /sql/eventdata-timestamp.sql

data_update.sh
