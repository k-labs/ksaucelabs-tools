#!/bin/bash
# loop over all input arguments (a list of domain names) and blacklist them via pointing them to localhost

echo > /tmp/hosts

for var in "$@"
do
    echo "127.0.0.1 $var" >> /tmp/hosts
done
cat /etc/hosts >> /tmp/hosts
cp -y /tmp/hosts /etc/hosts

# in case copying fails - see https://support.saucelabs.com/customer/portal/articles/2005376-edit-the-domain-name-system-dns-within-the-sauce-labs-virtual-machine-vm-

export HOSTALIASES=/tmp/hostaliases
