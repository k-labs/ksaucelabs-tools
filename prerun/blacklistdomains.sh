#!/bin/bash
# loop over all input arguments (a list of domain names) and blacklist them via pointing them to a blackhole

# retrieve public IP of a VM owned by kaliop which we never use to host sites
# this can take a couple of seconds, but we try not to blacklist any IP which MIGHT get used...
# (using localhost IPs does not seem to work)
#BLACKHOLEIP=`dig +short ec2-54-148-20-76.us-west-2.compute.amazonaws.com`
# a google ip :-)
BLACKHOLEIP=173.194.45.48

echo > /tmp/hostaliases
for var in "$@"
do
    echo "$BLACKHOLEIP $var" >> /tmp/hostaliases
done
cat /etc/hosts >> /tmp/hostaliases

#cat /tmp/hostaliases

# NB: currrently only stdout of this script is acptured by saucelabs in https://assets.saucelabs.com/jobs/xxxxxx/prerun.log

# NB: currently sudo fails with 'sudo: no tty present and no askpass program specified'
sudo cp -f /tmp/hostaliases /etc/hosts 2>&1

# for good measure, make sure that we drop *quickly* all requests to the blackholed IP
# (alternative: set up a web server on ec2-54-148-20-76.us-west-2.compute.amazonaws.com)
# NB: it seems that iptables is not installed in the Saucelabs VMs...
sudo iptables -I OUTPUT -p tcp -d $BLACKHOLEIP -j REJECT 2>&1

#cat /etc/hosts
#sleep 30

# if running via sauceconnect - we might possibly do this instead...
# see https://support.saucelabs.com/customer/portal/articles/2005376-edit-the-domain-name-system-dns-within-the-sauce-labs-virtual-machine-vm-
#export HOSTALIASES=/tmp/hostaliases
