#!/bin/bash

usage() {
	echo "Usage: $0 [SRC] [DST]"
	echo " ex) $0 192.168.51.2 192.168.1.2"
	exit 0
}

if [ -z "$2" ]; then
	usage
		
fi

insert_rule() {
	CHAIN_NAME=$1
	SRC_NET=$2
	DST_NET=$3

	iptables -I $CHAIN_NAME 2 -s $SRC_NET -d $DST_NET -j RETURN
}

CHAIN_NAME=neutron-openvswi-s303d1159-0
SRC_NET=$1
DST_NET=$2

insert_rule $CHAIN_NAME $SRC_NET $DST_NET

