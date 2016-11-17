#!/bin/bash
# check if it exists in package files - otherwise, use PPA
if [[ ! $(sudo apt-cache search synapse | grep "^synapse ") ]]; then
	echo "Synapse not found in repository. Adding PPA."
	sudo apt-add-repository ppa:synapse-core/ppa
	sudo apt-get update
fi
sudo apt-get install -y synapse
