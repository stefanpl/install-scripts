#!/bin/bash
source $( dirname $0  )/utils.sh
requireRoot

apt-get install -y php7.0-dev 

# Check if pecl is available.
# Should be through php7.0-dev
pecl -v > /dev/null 2>&1
if [ $? -ne 0 ]; then
    exitWithError 'pecl is required to install xdebug, but could not be found.'
fi

# Check if xdebug is already installed 
pecl list | grep -q xdebug
if [ $? -ne 0 ]; then
    pecl install xdebug
else
    logInfo 'xdebug already installed via pecl'
fi

extensionPath=$(pecl list-files xdebug | egrep ^src | perl -p -e 's/^src[^\/]+//')
if [ "${extensionPath}" = "" ]; then 
    exitWithError 'Could not locate the xdebug extension via pecl. Aborting.'
fi
extensionPath='zend_extension="'${extensionPath}'"'

# TODO: check if the line is contained already in php.ini

find /etc/php/ -type f -name php.ini | while read -r inifile; do \
    # check if xdebug is already mentioned in php.ini
    grep -q "xdebug" ${inifile}
    if [ $? -ne 0 ]; then
        printf "\n\n# Added by install-script\n" >> $inifile
        printf $extensionPath"\n" >> $inifile
        logSuccess "Added ${extensionPath} to ${inifile}"
    else
        # Check if same line we are trying to add is already present.
        # This would be okay – otherwise, assume an error.
        grepping="grep -q '${extensionPath}' ${inifile}"
        eval $grepping
        if [ $? -ne 0 ]; then
            logError "Already found 'xdebug' mentioned in ${inifile}, but not the line we are assuming."
            exitWithError "Please review this error by hand. Aborting."
        else 
            logSuccess "xdebug already present in ${inifile}"
        fi
    fi
done

logSuccess 'Installed xdebug. You might need to restart the web server now to use it.'
logSuccess 'You might need to manually adjust settings, such as xdebug.remote_enable and xdebug.remote_host.'