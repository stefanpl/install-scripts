#!/bin/bash
source $( dirname $0  )/utils.sh
requireRoot

apt-get install virtualbox virtualbox-qt virtualbox-dkms virtualbox-guest-dkms
