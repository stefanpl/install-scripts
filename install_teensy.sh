#!/bin/bash
source $( dirname $0  )/utils.sh
requireRoot

cd `mktemp -d`

udevRulesDownloadUrl=https://www.pjrc.com/teensy/49-teensy.rules
udevRulesFile=49-teensy.rules
curl --silent -o ${udevRulesFile} ${udevRulesDownloadUrl}
cp ${udevRulesFile} /etc/udev/rules.d/


teensyDownloadUrl=https://www.pjrc.com/teensy/teensy_linux64.tar.gz
teensyArchive=teensy.tar.gz
curl --silent -o ${teensyArchive} ${teensyDownloadUrl}
tar -xf ${teensyArchive}
chmod 770 teensy
chown ${USER}:${USER} teensy

binDirectory=/usr/local/bin
if [ ! -d ${binDirectory} ]; then
  exitWithError "Could not find directory ${binDirectory}."
else
  mv teensy ${binDirectory}
fi