#!/bin/bash

docker -H='tcp://127.0.0.1:4243' run -dns=$REDIS_DNS -d $DOCKER_PHPMYADMIN
