#!bin/bash
git clone https://github.com/stefanpl/oh-my-zsh $HOME/.oh-my-zsh ;
ln -s $HOME/.oh-my-zsh/.zshrc $HOME
sudo apt-get install -y zsh
touch $HOME/.bash_aliases_private
