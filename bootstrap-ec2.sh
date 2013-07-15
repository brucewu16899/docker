#!/usr/bin/env bash

# The linux-image-extra package is only needed on standard Ubuntu EC2 AMIs in order to install the aufs kernel module. 
sudo apt-get install linux-image-extra-`uname -r`

#
# Upgrade the kernel
#

#sudo apt-get install -y linux-image-generic-lts-raring
sudo apt-get upgrade -y
sudo reboot

#
# Install docker.io etc
#

sudo apt-get install -y python-software-properties software-properties-common git
sudo add-apt-repository ppa:dotcloud/lxc-docker
sudo apt-get update
sudo apt-get install -y lxc-docker


#
# Build the docker images using Dockerfile
#

docker build - < /vagrant/Dockerfile
