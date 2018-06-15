#!/bin/bash
source $( dirname $0  )/utils.sh
# Requires the user to enter the sudo password
sudo echo "something" > /dev/null || exitWithError "Sudo password required to run this script"

# Install dependencies
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Import the key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88 | grep -e . > /dev/null || exitWithError "Importing key failed. Please investigate."

# Find out the repository name for our distro
ubuntuName=`cat /etc/*release 2>/dev/null | grep -i -e "ubuntu_codename" | perl -p -e "s/.*=//"`
if [ -z ${ubuntuName} ]; then
  exitWithError 'Could not determine ubuntu name. Is this a ubuntu installation? Please investigate.'
fi
repositoryLine="deb [arch=amd64] https://download.docker.com/linux/ubuntu ${ubuntuName} stable"
repositoryFile=/etc/apt/sources.list.d/additional-repositories.list

# add the repository if it's not already there
if [ -f ${repositoryFile} ]; then
  # The square brackets need to be escaped for grep
  searchExpression=`echo "${repositoryLine}" | perl -p -e 's/([\[\]])/\\\\$1/g'`
  if [ ! "`grep \"${searchExpression}\" ${repositoryFile}`" = "" ]; then
    logInfo "Repository has already been added to ${repositoryFile}"
  else
    sudo add-apt-repository ${repositoryLine}
  fi
else
  sudo add-apt-repository ${repositoryLine}
fi

sudo apt-get update
sudo apt-get install -y docker-ce

sudo usermod -a -G docker ${USER}

docker -v && logSuccess "Docker installed. Added user ${USER} to docker group."