#!/bin/bash
source $( dirname $0  )/utils.sh
# Requires the user to enter the sudo password
sudo echo "something" > /dev/null || exitWithError "Sudo password required to run this script"

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
apt-get install apt-transport-https
sourceListFile=/etc/apt/sources.list.d/sublime-text.list
if [ ! -f ${sourceListFile} ]; then
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee ${sourceListFile}
else
	logInfo "Sublime source list already existing at ${sourceListFile}."
fi

sudo apt-get update
sudo apt-get install -y sublime-text

# Install package control
packageDirectory=${HOME}/.config/sublime-text-3/Installed\ Packages/ 
mkdir -p "${packageDirectory}" 
cd "${packageDirectory}"
wget -q https://packagecontrol.io/Package%20Control.sublime-package

myUserConfigDirectory=${HOME}/.sublime-config/User
sublimeConfigDirectory=${HOME}/.config/sublime-text-3/Packages/
mkdir -p ${sublimeConfigDirectory}

if [ ! -d ${myUserConfigDirectory} ]; then
	git clone git@github.com:stefanpl/sublime-config.git ${HOME}/.sublime-config
fi

if [ ! -d ${myUserConfigDirectory} ]; then
	exitWithError "Could not find folder ${myUserConfigDirectory}. Something has gone wrong."
fi

ln -s ${myUserConfigDirectory} ${sublimeConfigDirectory} || exitWithError "Could not create symlink – installation failed. Please investigate."

logSuccess "Sublime text successfully installed!"
