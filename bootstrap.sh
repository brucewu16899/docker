#!/usr/bin/env bash

#
# This script installs the necessary stuff for the docker host.
# Images for the containers are built with Dockerfiles (see at the bottom)
#

#
# Varaibles used below
#

HOME=/home/vagrant


sudo apt-get update


#
# Clone this repo, sharing folders don't always work
#

sudo su vagrant -c "cd $HOME && git clone https://github.com/colmsjo/docker.git"


#
# Install docker.io
#

#sudo apt-get install -y python-software-properties software-properties-common python-pip python-dev libevent-dev
#sudo add-apt-repository ppa:dotcloud/lxc-docker
#sudo apt-get update
#DEBIAN_FRONTEND=noninteractive sudo apt-get install -y lxc-docker

# Need to run docker with other flags, this file need to be updated once the machine is up
#sudo cp $HOME/docker/etc/init/docker.conf /etc/init
sudo su vagrant -c "echo alias docker=\'docker -H=tcp://127.0.0.1:4243\' >> $HOME/.profile"
#sudo service docker restart


# Add the Docker repository key to your local keychain
sudo sh -c "curl -k https://get.docker.io/gpg | apt-key add -"

# Add the Docker repository to your apt sources list.
sudo sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"

# update your sources list
sudo apt-get update

# install the latest
sudo apt-get install -y lxc-docker



#
# Nifty tools
#

sudo apt-get install -y git unzip s3cmd curl
#dkms postgresql-client-common postgresql-client-9.1 mysql-client



#
# install and configure nodejs
#

#sudo apt-get -y install nodejs npm

# install nvm for root
sudo sh -c "wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh"

# update nodejs for root
sudo sh -c "source ~/.nvm/nvm.sh && nvm install v0.11.2"
sudo sh -c "source ~/.nvm/nvm.sh && nvm use v0.11.2"


# Install nvm - Node version manager for the vagrant user
su - vagrant -c "wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh"

# Install nodejs versions for vagrant user
su - vagrant -c "source ~/.nvm/nvm.sh && nvm install v0.8.0"
su - vagrant -c "source ~/.nvm/nvm.sh && nvm install v0.11.2"
su - vagrant -c "source ~/.nvm/nvm.sh && nvm use v0.11.2"


#
# Install NodeJs, grunt and Coffeescript
#

#sudo apt-get update -y
#sudo apt-get install -y python g++ make software-properties-common
#sudo add-apt-repository -y ppa:chris-lea/node.js
#sudo apt-get update -y
#sudo apt-get install -y nodejs

#sudo npm install grunt grunt-cli -g
#sudo npm install coffee-script -g production



#-----------------------------------------------------
# At bottom, manual reboot needed after this


#
# Kernel upgrade
#

sudo apt-get install -y linux-image-generic-lts-raring


