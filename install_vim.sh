#!/bin/bash
source $( dirname $0  )/utils.sh
requireRoot

# Determine which user zsh will be installed for
if [ $1 ]; then
	ensureUserExists $1
	USER=$1
else
	echo "No username provided (first argument to this script). Installing for current user".
fi
echo "Installing for user "$USER.
HOME=$(getHomeDirectoryForUser $USER)

# install vim
vim --version 2>/dev/null > /dev/null
if [ $? -eq 0 ]
then
	echo "Vim is installed. Setup configuration"
else
	apt-get install -y vim
fi

# set up vim configuration 
if [ -d ${HOME}/.vim ] && [ -L ${HOME}/.vimrc ]
then
	logSuccess "Vim seems to be set up already. Have a go!"
else
	git clone https://github.com/stefanpl/vim-config $HOME/.vim
	ln -s $HOME/.vim/.vimrc $HOME
	cd $HOME/.vim
	git submodule update --init --recursive
    logSuccess "Vim is ready to rumble!"
fi
