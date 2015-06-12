#!/bin/bash
# loop over all input arguments (a list of domain names) and blacklist them via pointing them to a blackhole

# retrieve public IP of a VM owned by kaliop which we never use to host sites
# this can take a couple of seconds, but we try not to blacklist any IP which MIGHT get used...
# (using localhost IPs does not seem to work)
BLACKHOLEIP=`dig +short ec2-54-148-20-76.us-west-2.compute.amazonaws.com`

echo > /tmp/hostaliases
for var in "$@"
do
    echo "$BLACKHOLEIP $var" >> /tmp/hostaliases
done
cat /etc/hosts >> /tmp/hostaliases

sudo cp -f /tmp/hostaliases /etc/hosts

# for good measure, make sure that we drop *quickly* all requests to the blackholed IP
# (alternative: set up a web server on ec2-54-148-20-76.us-west-2.compute.amazonaws.com)
# NB: it seems that this is not installed in the Saucelabs VMs...
###sudo iptables -I OUTPUT -p tcp -d $BLACKHOLEIP -j REJECT

xterm -e "cat /etc/hosts && sleep 30"

#cat /etc/hosts
#sleep 30

# if running via sauceconnect - see https://support.saucelabs.com/customer/portal/articles/2005376-edit-the-domain-name-system-dns-within-the-sauce-labs-virtual-machine-vm-
#
#export HOSTALIASES=/tmp/hostaliases
