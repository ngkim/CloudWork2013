#!/bin/bash

HOST=$1

if [ -z $HOST ]; then
    echo "Usage: $0 [compute-node]"
    echo "   ex) $0 tst-goss4" 
    exit -1
fi

echo "*** Disable nova-compute at $HOST"
nova-manage service disable $HOST nova-compute

echo "*** List of services"
nova-manage service list | grep -v DEBUG
