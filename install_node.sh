#!/bin/bash
source $( dirname $0 )/utils.sh
requireRoot

# Determine which user nvm will be installed for 
if [ $1 ]; then
    ensureUserExists $1
    USER=$1
else
    echo "No username provided (first argument to this script). Installing for current user".
fi
echo "Installing for user "$USER.
HOME=$(getHomeDirectoryForUser $USER)

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
nvm install --lts=carbon
chown -R $USER:$USER $HOME/.nvm

# Install pm2, the node process manager
npm install -g pm2

