#!/usr/bin/env bash

#
# This script installs the necessary stuff for the docker host.
#

#
# Varaibles used below
#

HOME=/home/vagrant

# Clone this repo, sharing folders don't always work
sudo su vagrant -c "cd $HOME && git clone https://github.com/colmsjo/docker.git"

# Turn off protection of config files, install systemd etc.
sudo cp ./gentoo/etc/portage/make.conf   /etc/portage/
sudo cp ./gentoo/etc/portage/package.use /etc/portage/
sudo cp ./gentoo/boot/grub/grub.conf     /boot/grub/

#sudo su -c 'echo CONFIG_PROTECT=\"-*\" >> /etc/portage/make.conf'

# Update portage itself first
sudo emerge --oneshot portage

# Download latest version of repository
sudo emerge --sync

# Install kernel sources, needed for the world update (compile) below
sudo emerge sys-kernel/gentoo-sources

# Install systemd
sudo ln -sf /proc/self/mounts /etc/mtab

#sudo su -c 'echo USE=\"systemd symlink -consolekit\" >> /etc/portage/make.conf'
#sudo su -c 'echo sys-apps/dbus -systemd >> /etc/portage/package.use'
#sudo su -c 'echo =dev-libs/openssl-1.0.1e-r1 bindist >> /etc/portage/package.use'

# Generate kernel options
sudo genkernel all --bootloader=grub all

# Update everything and install systemd at the same time
sudo emerge --update world


# Install some tools
sudo emerge nano


#
# Install docker.io
#

sudo emerge app-emulation/docker --autounmask-write
sudo systemctl enable docker.service
sudo systemctl start docker.service


# Fix for emerge warning
#sudo mkdir /var/lib/layman/lxmx/metadata/
#sudo su -c "echo masters = gentoo >> /var/lib/layman/lxmx/metadata/layout.conf"
# sudo sudo etc-update

# Install redis, used by hipache and redis-dns
# Need to run docker with other flags, this file need to be updated once the machine is up
#

sudo emerge dev-db/redis

wget http://download.redis.io/releases/redis-2.6.16.tar.gz
tar xzf redis-2.6.16.tar.gz
cd redis-2.6.16; make

#
# Nifty tools
#

#sudo apt-get install -y git unzip s3cmd curl dkms postgresql-client-common postgresql-client-9.1 mysql-client supervisor


#
# Install NodeJs
#

sudo su -c "git clone https://github.com/creationix/nvm.git ~/.nvm"
sudo su -c "echo source ~/.nvm/nvm.sh >> /etc/profile.d/nvm.profile"
sudo su -c "source ~/.nvm/nvm.sh; nvm install v0.11.6"


# Install hipache and redis-dns directly instead of using Jacc
#


sudo su -c "source ~/.nvm/nvm.sh; nvm use v0.11.6; npm install hipache -g --production"

#sudo cp $HOME/docker/usr/lib/node_modules/redis-dns/redis-dns-config.json /usr/lib/node_modules/redis-dns
#sudo cp $HOME/docker/etc/init/redis-dns.conf /etc/init
#sudo service redis-dns restart


#sudo npm install hipache -g --production
#sudo cp $HOME/docker/usr/lib/node_modules/hipache/hipache-config.json /usr/lib/node_modules/hipache
#sudo cp $HOME/docker/etc/init/hipache.conf /etc/init
#sudo service hipache restart


#
# Install grunt, used for nodejs development
#

#sudo npm install grunt grunt-cli -g


# Use the local nameserver and then google's
# NOTE: sometimes usefull when using mobile broadband
#sudo sh -c 'echo "dns-nameservers localhost 8.8.8.8" >> /etc/network/interfaces'


#
# Setup ubuntu env
#

#sudo sh -c "cat $HOME/docker/etc/environment >> /etc/environment"
#sudo sh -c "cat $HOME/docker/etc/sudoers >> /etc/sudoers"dev-libs/openssl-1.0.1e-r1 bindist

