#!/bin/bash
source $( dirname $0 )/utils.sh
requireRoot

# This script will install the latest node version via nvm
# https://github.com/creationix/nvm

function installNvm {
	# First, find the current version of the nvm repo
	nvmVersion=$(wget -qO- https://raw.githubusercontent.com/creationix/nvm/master/package.json | grep '"version":' | perl -p -e 's/[^0-9]*([0-9.]+).*/$1/')
	# Use the install script from the latest version
	wget -qO- https://raw.githubusercontent.com/creationix/nvm/v$nvmVersion/install.sh | bash
    source $HOME/.nvm/nvm.sh
}

installNvm
nvm install --lts=boron
chown -R $USER:$USER $HOME/.nvm

# Install pm2, the node process manager
npm install -g pm2