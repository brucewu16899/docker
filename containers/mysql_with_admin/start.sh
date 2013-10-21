#!/bin/bash

/usr/bin/mysqld_safe &
sleep 2

/usr/sbin/apache2ctl start

/usr/bin/tail -f /var/log/mysql.log
