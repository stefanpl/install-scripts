#!/bin/bash
source $( dirname $0  )/utils.sh
requireRoot

# get dependencies
apt-get install -y python-pip python-setuptools

pip2 install https://github.com/ssokolow/quicktile/archive/master.zip

# Generate the default config file, but delete it afterwards
quicktile
quicktileDefaultConfigFile=${HOME}/.config/quicktile.cfg
if [ ! -f ${quicktileDefaultConfigFile} ]; then
	logInfo "Could not locate ${quicktileDefaultConfigFile}, this is unusual and might indicate an error."
else
	rm ${quicktileDefaultConfigFile}
fi

# Set the config file from dotfiles
ensureDotfilesExist
quicktileConfigFile=${HOME}/.dotfiles/quicktile/quicktile.cfg
# get the configuration file
if [ -f ${quicktileConfigFile} ]; then
	ln -s ${quicktileConfigFile} ${HOME}/.config/
else
	exitWithError "Could not locate quicktile config file at ${quicktileConfigFile}."
fi

autostartDirectory=${HOME}/.config/autostart
autostartFile=${autostartDirectory}/quicktile.desktop
mkdir -p ${autostartDirectory}
chown ${USER}:${USER} ${autostartDirectory}

if [ ! -f ${autostartFile} ]; then
	echo "[Desktop Entry]" >> ${autostartFile}
	echo "Type=Application" >> ${autostartFile}
	echo "Name=Quicktile" >> ${autostartFile}
	echo "Exec=quicktile --daemonize" >> ${autostartFile}
	chown ${USER}:${USER} ${autostartFile}
fi

# Launch it
quicktile --daemonize

logSuccess "Quicktile set up successfully."
