#!/bin/bash


usage() {
    echo "Usage: $0 [node-to-backup]"
    echo "   ex) $0 controller" 

    lshw -c network -short
}

ITF=$1
if [ -z $ITF ]; then
    usage; exit -1
fi

MAC_ADDR=`ifconfig $ITF | grep HWaddr | awk '{print $5}'`

ifconfig $ITF hw ether $MAC_ADDR up

