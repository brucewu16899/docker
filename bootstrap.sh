#!/usr/bin/env bash

#
# Varaibles used below
#

HOME=/home/vagrant


#
# Nifty tools
#

sudo apt-get update
sudo apt-get install -y git unzip s3cmd curl


#
# Clone this repo, sharing folders don't always work
#

su vagrant -c "cd $HOME && git clone https://github.com/colmsjo/docker.git"



#
# install and configure nodejs
#

# install nvm for root
su vagrant -c "cd $HOME && wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh"

# update nodejs
su vagrant -c "cd $HOME && source $HOME/.nvm/nvm.sh && nvm install v0.11.2"
su vagrant -c "cd $HOME && source $HOME/.nvm/nvm.sh && nvm use v0.11.2"

