#!/bin/bash
source $( dirname $0  )/utils.sh
requireRoot

apt-get install -y virtualbox virtualbox-qt virtualbox-guest-utils virtualbox-dkms virtualbox-guest-dkms nfs-kernel-server
