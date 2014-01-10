#!/bin/bash

usage() {
 	echo "Usage: $0 [node-to-backup]"
 	echo "   ex) $0 controller" 
}

NODE=$1
if [ -z $NODE ]; then
	usage; exit -1
fi

scp etc/network/interfaces $NODE:/etc/network/interfaces

ssh $NODE "service networking restart"


