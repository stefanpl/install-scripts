#!bin/bash
if [ -d ~/.oh-my-zsh ] && [ -h ~/.zshrc ]
then
	# oh-my-zsh seems to be installed. Check if zsh needs to be installed
	zsh --version 2>/dev/null > /dev/null
	if [ $? -eq 0 ]
	then
		echo "zsh already installed."
	else
		echo "installing z shell"
		sudo apt-get install -y zsh
	fi

	# just run usermod command. There's no harm if zsh is already set
	# first double-check if zsh is available at /bin/zsh
	if [ -x /bin/zsh ]
	then 
		sudo usermod -s /bin/zsh $USER
	else
		echo "something seems odd. zsh should be installed but is not available at /bin/zsh"
		exit 1
	fi

else
	# setup oh-my-zsh
	git clone https://github.com/stefanpl/oh-my-zsh $HOME/.oh-my-zsh ;
	ln -s ~/.oh-my-zsh/.zshrc ~
fi
