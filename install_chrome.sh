#!/bin/bash
source $( dirname $0  )/require_root.sh

if [[ $(uname -a | grep "x86_64") ]]; then
	pushd /tmp/
	curl -o chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	dpkg -i chrome.deb
	popd > /dev/null
else
	echo "Chrome does not support 32bit systems any longer. chromium-browser package might be an alternative."
fi
