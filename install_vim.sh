#!bin/bash
sudo apt-get install -y vim
git clone https://github.com/stefanpl/vim-config $HOME/.vim
ln -s $HOME/.vim/.vimrc $HOME
cd $HOME/.vim
git submodule update --init --recursive
