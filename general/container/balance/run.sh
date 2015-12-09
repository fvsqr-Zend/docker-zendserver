#!/bin/bash

php /balance_conf.php

while inotifywait -e close_write /etc/hosts 1>/dev/null 2>/dev/null; do
  killall balance
  php /balance_conf.php
done

exec tail -f /var/log/dpkg.log > /dev/null
