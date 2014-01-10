#!/bin/bash

source "$MNG_ROOT/include/print.sh"

if [ -z $1 ]; then
	echo "Usage: $0 [HOST_IP]"
	echo "   ex) $0 50.50.1.4"
	exit
fi

MODE="PREPARE-LOG-PPS"
HOST_IP=$1

print_info $MODE "Create $MNG_ROOT directory"
ssh $HOST_IP mkdir -p $MNG_ROOT/bin
ssh $HOST_IP mkdir -p $MNG_ROOT/include

print_info $MODE "Copy files for log-pps"
scp $MNG_ROOT/include/util.sh 		$HOST_IP:$MNG_ROOT/include
scp $MNG_ROOT/include/print.sh 		$HOST_IP:$MNG_ROOT/include
scp $MNG_ROOT/include/netstat.sh	$HOST_IP:$MNG_ROOT/include

scp $MNG_ROOT/bin/nfs/init-env.sh 	$HOST_IP:$MNG_ROOT/bin

scp $MNG_ROOT/bin/log-pps/start-log-pps.sh 	$HOST_IP:$MNG_ROOT/bin
scp $MNG_ROOT/bin/log-pps/stop-log-pps.sh 	$HOST_IP:$MNG_ROOT/bin

print_info $MODE "Run init-env.sh"
ssh $HOST_IP $MNG_ROOT/bin/init-env.sh
