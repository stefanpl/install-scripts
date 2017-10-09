#!/bin/bash
source $( dirname $0  )/utils.sh
requireRoot

locale-gen "en_US.UTF-8"
locale-gen "de_DE.UTF-8"
locale-gen --purge de_DE.UTF-8 en_US.UTF-8