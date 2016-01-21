#!bin/bash
# install vim
vim --version 2>/dev/null > /dev/null
if [ $? -eq 0 ]
then
	echo "Vim is installed. Setup configuration"
else
	sudo apt-get install -y vim
fi

# set up vim configuration 
if [ -d ~/.vim ] && [ -L ~/.vimrc ]
then
	echo "Vim seems to be set up already. Have a go!"
else
	git clone https://github.com/stefanpl/vim-config $HOME/.vim
	ln -s $HOME/.vim/.vimrc $HOME
	cd $HOME/.vim
	git submodule update --init --recursive
fi
