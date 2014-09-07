#!/bin/bash
service rsyslog start
service postfix start
echo "start" > /var/log/messages
sleep 5
tail -f /var/log/mail.log -f /var/log/messages