#!/bin/bash
# apt-get install php7.0-dev
# apt-get install pear
tempfile=$(mktemp)
cat /tmp/somefile > $tempfile
# pecl install xdebug | tee $tempfile
# filter out the line that needs to be added to php.ini
extensionLine=$(grep -iE "You should add \"zend_extension.*to php\.ini" $tempfile | perl -p -e 's/[^"]+"([^"]+)".*/$1/');  

# TODO: check if the line is contained already in php.ini

find /etc/php/ -type f -name php.ini | while read -r inifile; do \
    echo "Adding xdebug to php.ini at "$inifile
    printf "\n\n# Added by install-script\n" >> $inifile
    printf $extensionLine"\n" >> $inifile
done