#!/bin/bash
if [ "$EUID" -ne 0  ]
then echo "Please run as root"
	exit
fi
USER=$(logname || whoami)
echo "Installing for user $USER"
