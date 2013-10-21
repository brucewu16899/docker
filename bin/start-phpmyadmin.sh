#!/bin/bash

docker run -dns=$REDIS_DNS -d $DOCKER_PHPMYADMIN
