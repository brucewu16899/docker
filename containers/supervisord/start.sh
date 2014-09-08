#!/bin/bash
supervisord &
sleep 5
tail -f /var/log/supervisor/supervisord.log
