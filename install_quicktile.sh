#!/bin/bash

# get dependencies
sudo apt-get install -y python python-gtk2 python-xlib python-dbus python-wnck

# get the script
sudo curl -o /opt/quicktile.py https://raw.githubusercontent.com/ssokolow/quicktile/master/quicktile.py
sudo chmod +x /opt/quicktile.py 
sudo chown "$USER":"$USER" /opt/quicktile.py 

# make it autostart
autostart_dir="$HOME"/.config/autostart/
autostart_file="$autostart_dir"quicktile
mkdir -p $autostart_dir
echo "[Desktop Entry]" >> autostart_file
echo "Type=Application" >> autostart_file
echo "Name=Quicktile" >> autostart_file
echo "Exec=/opt/quicktile.py --daemonize" >> autostart_file

# get the configuration file
if [ ! -d "$HOME"/dotfiles ]; then
	git clone https://github.com/stefanpl/dotfiles $HOME
fi
if [ -f "$HOME"/dotfiles/quicktile.cfg ]; then
	ln -s "$HOME"/dotfiles/quicktile.cfg "$HOME"/.config/
else
	echo ERROR: found "$HOME"/dotfiles but no quicktile.cfg in it
	exit 2
fi

# fiah it up right now
/opt/quicktile.py --daemonize &


