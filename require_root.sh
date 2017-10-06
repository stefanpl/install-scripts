#!/bin/bash
if [ "$EUID" -ne 0  ]
then echo "Please run as root"
	exit
fi
# We are interested in getting the user running the script
if [ ! "$SUDO_USER" = '' ]; then
	USER=$SUDO_USER
fi
# Reset $HOME with corrected user
HOME=$( getent passwd "$user" | cut -d: -f6 )
