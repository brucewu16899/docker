#!/bin/bash
#
# This script does something like this:
# docker run -d IMAGE_ID
# redis-cli rpush frontend:www.gizur.com gizur_com
# docker inspect CONTAINER_ID - search for IP address
# redis-cli rpush frontend:www.gizur.com http://[IP ADDRESS]:8080
#

#CONTAINER_ID=$(docker run -d -dns=$REDIS_DNS $1)
CONTAINER_ID=$(docker run -d  $1)
redis-cli rpush frontend:www.gizur.com gizur_com
IPADDRESS=$(docker inspect $CONTAINER_ID|grep IPAddress|cut -c 23-33)
redis-cli rpush frontend:www.gizur.com http://$IPADDRESS
