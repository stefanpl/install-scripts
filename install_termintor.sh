#!/bin/bash
source $( dirname $0  )/utils.sh
requireRoot

apt-get install -y terminator
ensureDotfilesExist

configDirectory=${HOME}/.config/terminator
mkdir -p ${configDirectory}
chown ${USER}:${USER} ${configDirectory}

configFile=${HOME}/.dotfiles/terminator/config
if [ ! -f ${configFile} ]; then
	exitWithError "Could not find terminator config file at ${configFile}"
fi

ln -s ${configFile} ${configDirectory}/

logSuccess "Terminator installed for ${USER}."
