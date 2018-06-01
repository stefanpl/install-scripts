#!/bin/bash
source $( dirname $0  )/utils.sh
requireRoot

# check if it exists in package files - otherwise, use PPA
if [[ ! $(apt-cache search synapse | grep "^synapse ") ]]; then
	echo "Synapse not found in repository. Adding PPA."
	apt-add-repository ppa:synapse-core/ppa
	apt-get update
fi
apt-get install -y synapse

configDirectory=${HOME}/.config/synapse
mkdir -p ${configDirectory}
chown ${USER}:${USER} ${configDirectory}

ensureDotfilesExist
synapseConfigFile=${HOME}/.dotfiles/synapse/config.json
if [ ! -f ${synapseConfigFile} ]; then
	exitWithError "Could not locate synapse config file at ${synapseConfigFile}."
fi

if [ -f ${configDirectory}/config.json ]; then
	rm ${configDirectory}/config.json
fi
ln -s ${synapseConfigFile} ${configDirectory}/

logSuccess "Synapse set up successfully"
