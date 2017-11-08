#!/bin/bash
source $( dirname $0 )/utils.sh
requireRoot

# Setting MYSQL_ROOT_PW prior to running this script will change the root user's password.
# When running the script manually via sudo, use the -E flag to keep env variables:
# 
#  export MYSQL_ROOT_PW=password
#  sudo -E ./install_mysql.sh
# 
# Not setting it will result in root // root.

if [ -z ${MYSQL_ROOT_PW+set} ]; then
    echo 'MYSQL_ROOT_PW not set. Using default password for mysql root user'
    rootPassword=root
else
    echo 'root user password provided via MYSQL_ROOT_PW'
    rootPassword=$MYSQL_ROOT_PW
fi

debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password password ${rootPassword}"
debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password_again password ${rootPassword}"

apt-get install -y mysql-server-5.7