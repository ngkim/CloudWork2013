#!/bin/bash

usage() {
	echo "Usage: $0 [SRC]"
	echo " ex) $0 192.168.51.2"
	exit 0
}

if [ -z "$1" ]; then
	usage
		
fi

insert_rule() {
	CHAIN_NAME=$1
	SRC_NET=$2

	iptables -I $CHAIN_NAME 2 -s 0.0.0.0/0 -d $SRC_NET -p all -j RETURN
}

#CHAIN_NAME=neutron-openvswi-s303d1159-0
CHAIN_NAME=neutron-openvswi-sb418b43d-1
SRC_NET=$1

insert_rule $CHAIN_NAME $SRC_NET

