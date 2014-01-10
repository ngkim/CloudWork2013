#!/bin/bash

source "$MNG_ROOT/include/print.sh"

HOST=$1
if [ -z $HOST ]; then
    echo "Usage: $0 [dest]"
    echo "   ex) $0 controller" 
    exit -1
fi

print_info $MODE "Copy /etc/hosts.allow"
scp /etc/hosts.allow $HOST:/etc/hosts.allow

print_info $MODE "Copy /etc/hosts.deny"
scp /etc/hosts.deny $HOST:/etc/hosts.deny



