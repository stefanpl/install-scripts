#!/bin/bash
source $( dirname $0 )/utils.sh
requireRoot

# Check if release string contains 16.04. Abort if not.
cat /etc/*release 2>/dev/null | grep "16.04" || \
	(echo "You must be running ubuntu 16.04 to execute this script." && exit 1)
echo "This script is for ubuntu 16.04 only. Is this a 16.04 host?"
options=("Yes" "No")
select yn in "${options[@]}"
do
	case $yn in
		Yes) break;;
		No) Not a 16.04 host. Bye-bye! exit 1;;
		*) echo "Type '1' for Yes or '2' for No ..." 
	esac
done

# The actual installation process
wget https://apt.puppetlabs.com/puppet5-release-xenial.deb
dpkg -i puppet5-release-xenial.deb
apt-get update
apt-get install -y puppet-agent
# make sure the PATH is included
export PATH=/opt/puppetlabs/bin:$PATH
# r10k for advanced puppet deployment
if [ ! $(gem --version > /dev/null) ]; then
	apt-get install -y ruby
fi
gem --version > /dev/null || (echo 'rubygems not available. Exiting.' && exit 1)
gem install r10k
puppetpath=/etc/puppetlabs/puppet
cp ./resources/puppet.conf $puppetpath/puppet.conf

# get the puppetfile
cd $puppetpath
cp /vagrant/puppet-setup/* .
r10k puppetfile install
puppet apply --modulepath=$puppetpath/modules site.pp
