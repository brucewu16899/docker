#!/bin/bash

/usr/sbin/apache2ctl start

/usr/bin/tail -f /var/log/apache2/error.log -f /var/log/apache2/access.log
