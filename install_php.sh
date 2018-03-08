#!/bin/bash
source $( dirname $0 )/utils.sh
requireRoot

apt-get install -y php7.0
apt-get install -y php7.0-mbstring
apt-get install -y php7.0-mysql
apt-get install -y php7.0-zip
apt-get install -y php7.0-xml
apt-get install -y php7.0-json
apt-get install -y php7.0-gd


phpenmod pdo_mysql

function installComposer {
    # install composer. 
    # https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
    EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then
        >&2 echo 'ERROR: Invalid installer signature'
        rm composer-setup.php
        exit 1
    fi

    php composer-setup.php --quiet
    RESULT=$?
    rm composer-setup.php
    mv composer.phar /usr/local/bin/composer
    return $RESULT
}

exit $(installComposer)