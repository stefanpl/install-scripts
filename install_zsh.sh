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

if [ -d $HOME/.oh-my-zsh ] && [ -h $HOME/.zshrc ]
then
	echo "oh-my-zsh seems to be ready ..."
else
	# setup oh-my-zsh
	git clone https://github.com/stefanpl/oh-my-zsh $HOME/.oh-my-zsh ;
	ln -s $HOME/.oh-my-zsh/.zshrc $HOME
	ln -s $HOME/.oh-my-zsh/.zshenv $HOME
    	chown -R $USER:$USER $HOME/.oh-my-zsh $HOME/.zshrc $HOME/.zshenv
fi

# Check if zsh needs to be installed
zsh --version > /dev/null 2>&1
if [ $? -eq 0 ]
then
	echo "zsh already installed ..."
else
	echo "installing z shell ..."
	apt-get install -y zsh
fi

# just run usermod command. There's no harm if zsh is already set
# first double-check if zsh is available at /bin/zsh
if [ -x /bin/zsh ]; then
	usermod -s /bin/zsh $USER > /dev/null 2>&1
else
	exitWithError "something seems odd – zsh should be installed but is not available at /bin/zsh"
fi

logSuccess "zsh and .oh-my-zsh installed for user $USER."
exit 0
