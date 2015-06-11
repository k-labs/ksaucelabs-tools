#!/bin/bash
# loop over all input arguments (a list of domain names) and blacklist them via pointing them to localhost

for var in "$@"
do
    echo "127.0.0.1 $var" >> /etc/hosts
done
