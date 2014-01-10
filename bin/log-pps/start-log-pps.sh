#!/bin/bash

if [ -z $MNG_ROOT ]; then
	MNG_ROOT=$HOME/nfs-devstack
fi

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/netstat.sh"

if [ -z $2 ]; then
	echo "Usage: $0 [NIC] [PPS_LOG]"
	echo "   ex) $0 eth0 /tmp/pps.log"
	exit
fi

NIC=$1
PPS_LOG=$2

start_log_pps $NIC $PPS_LOG
