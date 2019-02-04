#!/bin/bash
set -e

source $( dirname $0  )/utils.sh
# Requires the user to enter the sudo password
sudo echo "something" > /dev/null || exitWithError "Sudo password required to run this script"

logInfo "Installing dependencies …"
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common > /dev/null


logInfo "Importing repository key …"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - > /dev/null
sudo apt-key fingerprint 0EBFCD88 | grep -e . > /dev/null || exitWithError "Importing key failed. Please investigate."


logInfo "Trying to determine OS version …"
ubuntuName=`cat /etc/*release 2>/dev/null | grep -i -e "ubuntu_codename" | perl -p -e "s/.*=//"`
if [ -z ${ubuntuName} ]; then
  exitWithError 'Could not determine ubuntu name. Is this a ubuntu installation? Please investigate.'
fi
repositoryLine="deb [arch=amd64] https://download.docker.com/linux/ubuntu ${ubuntuName} stable"
repositoryFile=/etc/apt/sources.list.d/additional-repositories.list

function addRepository {
  fullCommand="sudo add-apt-repository \"${repositoryLine}\""
  eval ${fullCommand}
}


logInfo "Adding the docker repository …"
if [ -f ${repositoryFile} ]; then
  # The square brackets need to be escaped for grep
  searchExpression=`echo "${repositoryLine}" | perl -p -e 's/([\[\]])/\\\\$1/g'`
  if [ "`grep \"${searchExpression}\" ${repositoryFile}`" = "" ]; then
    addRepository
  fi
else
  addRepository
fi

logInfo "Running apt-get update …"
sudo apt-get update > /dev/null
logInfo "Installing docker-ce …"
sudo apt-get install -y docker-ce > /dev/null

logInfo "Adding user ${USER} to the docker group …"
sudo usermod -a -G docker ${USER}

docker -v && logSuccess "Docker installed successfully. IMPORTANT: log out and back in to apply user permissions. Then run *sudo service docker start*"