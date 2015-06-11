#!/bin/bash
# loop over all input arguments (a list of domain names) and blacklist them via pointing them to localhost

echo > /tmp/hosts

for var in "$@"
do
    echo "127.0.0.1 $var" >> /tmp/hostaliases
done
cat /etc/hosts >> /tmp/hostaliases
cp -y /tmp/hostaliases /etc/hosts
sudo cp -y /tmp/hostaliases /etc/hosts

#cat /etc/hosts
#sleep 30

# if running via sauceconnect - see https://support.saucelabs.com/customer/portal/articles/2005376-edit-the-domain-name-system-dns-within-the-sauce-labs-virtual-machine-vm-
#
#export HOSTALIASES=/tmp/hostaliases
