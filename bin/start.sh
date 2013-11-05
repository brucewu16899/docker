#!/bin/bash
#
# This script does something like this:
# docker run -d IMAGE_ID
# redis-cli rpush frontend:www.gizur.com gizur_com
# docker inspect CONTAINER_ID - search for IP address
# redis-cli rpush frontend:www.gizur.com http://[IP ADDRESS]:8080
#

if [ $# -ne 3 ] 
then
  echo "Usage: `basename $0` <docker container id> <web app address> <port>"
  exit 0
fi

#CONTAINER_ID=$(/usr/bin/docker -H=tcp://127.0.0.1:4243 -dns=$REDIS_DNS $1)

echo "Running: /usr/bin/docker -H=tcp://127.0.0.1:4243 run -d  $1"
CONTAINER_ID=$(/usr/bin/docker -H=tcp://127.0.0.1:4243 run -d  $1)
echo "Got container id: $CONTAINER_ID"

IPADDRESS=$(/usr/bin/docker -H=tcp://127.0.0.1:4243 inspect $CONTAINER_ID|grep IPAddress|cut -c 23-32)
echo "Received IP Address: $IPADDRESS"

redis-cli del frontend:$2
redis-cli rpush frontend:$2 $2
redis-cli rpush frontend:$2 http://$IPADDRESS:$3
