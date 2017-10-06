#!/bin/bash
source $( dirname $0  )/utils.sh
requireRoot

# check if it exists in package files - otherwise, use PPA
if [[ ! $(apt-cache search synapse | grep "^synapse ") ]]; then
	echo "Synapse not found in repository. Adding PPA."
	apt-add-repository ppa:synapse-core/ppa
	apt-get update
fi
apt-get install -y synapse
