#!/bin/bash
supervisord &
echo "start of file" > /var/log/cronjob
sleep 5
tail -f /var/log/supervisor/supervisord.log -f /var/log/cronjob
