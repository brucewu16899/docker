#!/bin/bash

# install nvm for root user
if [ ! -f /usr/bin/node ]; then
    echo "/usr/bin/node not found! Copying."
    source $HOME/.nvm/nvm.sh; nvm use v0.11.2; n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr
fi

source $HOME/.nvm/nvm.sh; nvm use v0.11.2; cd /src; npm install -g odata-server
