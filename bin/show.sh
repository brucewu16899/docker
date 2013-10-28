#!/bin/bash

if [ $# -ne 1 ] 
then
  echo "Usage: `basename $0` <web app address>"
  exit 0
fi

redis-cli lrange frontend:$1 0 -1
