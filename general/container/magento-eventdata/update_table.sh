#!/bin/bash

set -x

DB_USER=admin
DB_PASS=admin
DB_HOST=db
DB_NAME=ZendServer
function update_table {
    mysql -u $DB_USER -p$DB_PASS -h $DB_HOST $DB_NAME -e "update $1 t_outer set $2 = (SELECT ts from (select $3, $now+($2-$orig)-7200 as ts FROM $1 t_inner group by t_inner.$3) t_middle where t_middle.$3 = t_outer.$3 )"
}

orig=$(mysql -u $DB_USER -p$DB_PASS -h $DB_HOST $DB_NAME -e "SELECT first_timestamp FROM events order by first_timestamp limit 1;" | grep -Eo '[0-9]+')
now=$(mysql -u $DB_USER -p$DB_PASS -h $DB_HOST $DB_NAME -e "SELECT UNIX_TIMESTAMP();" | grep -Eo '[0-9]+')

update_table events first_timestamp event_id
update_table events last_timestamp event_id
update_table stats_daily from_time id
update_table stats_daily until_time id
update_table stats_monthly from_time id
update_table stats_monthly until_time id
update_table stats_weekly from_time id
update_table stats_weekly until_time id
update_table urlinsight_requests_daily from_time id
update_table urlinsight_requests_daily until_time id
update_table urlinsight_requests_monthly from_time id
update_table urlinsight_requests_monthly until_time id
update_table urlinsight_requests_weekly from_time id
update_table urlinsight_requests_weekly until_time id

mysql -u $DB_USER -p$DB_PASS -h $DB_HOST $DB_NAME -e "UPDATE stats_daily SET entry_sub_type_id = CASE FLOOR(RAND() * 14) WHEN 0 THEN '1299' WHEN 1 THEN '1299' WHEN 2 THEN '1299' WHEN 3 THEN '1199' WHEN 4 THEN '1199' WHEN 5 THEN '1199' WHEN 6 THEN '1199' WHEN 7 THEN '1099' WHEN 8 THEN '1099' WHEN 9 THEN '199' WHEN 10 THEN '199' WHEN 11 THEN '199' WHEN 12 THEN '299' WHEN 13 THEN '299' END"
mysql -u $DB_USER -p$DB_PASS -h $DB_HOST $DB_NAME -e "UPDATE stats_weekly SET entry_sub_type_id = CASE FLOOR(RAND() * 14) WHEN 0 THEN '1299' WHEN 1 THEN '1299' WHEN 2 THEN '1299' WHEN 3 THEN '1199' WHEN 4 THEN '1199' WHEN 5 THEN '1199' WHEN 6 THEN '1199' WHEN 7 THEN '1099' WHEN 8 THEN '1099' WHEN 9 THEN '199' WHEN 10 THEN '199' WHEN 11 THEN '199' WHEN 12 THEN '299' WHEN 13 THEN '299' END"
mysql -u $DB_USER -p$DB_PASS -h $DB_HOST $DB_NAME -e "UPDATE stats_monthly SET entry_sub_type_id = CASE FLOOR(RAND() * 14) WHEN 0 THEN '1299' WHEN 1 THEN '1299' WHEN 2 THEN '1299' WHEN 3 THEN '1199' WHEN 4 THEN '1199' WHEN 5 THEN '1199' WHEN 6 THEN '1199' WHEN 7 THEN '1099' WHEN 8 THEN '1099' WHEN 9 THEN '199' WHEN 10 THEN '199' WHEN 11 THEN '199' WHEN 12 THEN '299' WHEN 13 THEN '299' END"
