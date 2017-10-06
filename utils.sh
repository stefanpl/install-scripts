#!/bin/bash

# Collection of utility functions

# ANSI COLOR CODES
RED='\033[0;31m'
NORMAL='\033[0m'
GREEN='\033[1;32m'


# Redirect the received string to stderr and exit 1
function exitWithError {
	printf "${RED}### ERROR: ### $1\n" 1>&2;
	exit 1;
}

# Requires the calling script to be run with root privileges.
# Sets the $USER env variable to the calling user.
function requireRoot {
	if [ "$EUID" -ne 0 ]; then
		exitWithError "Please run this script with root privileges."
	fi
	if [ ! "$SUDO_USER" = '' ]; then
		USER=$SUDO_USER
	fi
}

# Make sure a given user exists on the host.
function ensureUserExists {
	if [ -z $1 ]; then
		exitWithError "ensureUserExists must be called with a user name."
	fi
	if [ ! $(id -u $1 2>/dev/null) ]; then
		exitWithError "Invalid user '$1' provided."
	fi
}

# Return the home directory of a given user,
#  or the current user if none is provided.
function getHomeDirectoryForUser {
	if [ -z $1 ]; then
		user=$USER
	else
		user=$1
	fi
	ensureUserExists $user
	echo $( getent passwd "$user" | cut -d: -f6  )
}

function logSuccess {
	printf "${GREEN}$1\n"
}
