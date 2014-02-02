#!/bin/bash
#
# See https://launchpad.net/~bitcoin/+archive/bitcoin
#


# For Precise 12.04
#sudo sh -c 'echo "deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu precise main" >> /etc/apt/sources.list'
#sudo sh -c 'echo "deb-src http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu precise main" >> /etc/apt/sources.list'

# Bitcoin need correct time
sudo apt-get install -y ntpdate
sudo ntpdate 0.us.pool.ntp.org

sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install -y bitcoind

