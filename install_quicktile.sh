#!bin/bash
sudo apt-get install -y python python-gtk2 python-xlib python-dbus python-wnck
git clone https://github.com/ssokolow/quicktile.git /tmp/tmp_quicktile
mkdir -p $HOME/scripts
cp /tmp/tmp_quicktile/quicktile.py $HOME/scripts
chmod +x $HOME/scripts/quicktile.py
$HOME/scripts/quicktile.py
cd /tmp/tmp_quicktile
sudo /tmp/tmp_quicktile/setup.py install
