#!/bin/bash
# loop over all input arguments (a list of domain names) and blacklist them via pointing them to localhost

echo > /tmp/hostaliases

for var in "$@"
do
    echo "108.168.208.206 $var" >> /tmp/hostaliases
done
cat /etc/hosts >> /tmp/hostaliases
cp -f /tmp/hostaliases /etc/hosts 2>/dev/null
if [ $? -ne 0 ]; then sudo cp -f /tmp/hostaliases /etc/hosts

# for good measure, make sure that we drop quickly all outgoing requests
sudo iptables -I OUTPUT -p tcp -d 108.168.208.206 -j REJECT

#cat /etc/hosts
#sleep 30

# if running via sauceconnect - see https://support.saucelabs.com/customer/portal/articles/2005376-edit-the-domain-name-system-dns-within-the-sauce-labs-virtual-machine-vm-
#
#export HOSTALIASES=/tmp/hostaliases
