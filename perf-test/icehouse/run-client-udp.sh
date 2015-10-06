#!/bin/bash

source "$MNG_ROOT/include/print.sh"

usage() {
	echo "Usage: $0 [SERVER_IP] [BW] [NUM_ITERATION]"
	echo " ex) $0 192.168.51.2 100m 3"
	exit 0
}

if [ -z "$3" ]; then 
	usage
fi

MODE="PERF-TEST"
SERVER_IP=$1
BW=$2
NUM_ITERATION=$3

for i in `seq 1 $NUM_ITERATION`; do
	print_info $MODE "$i ---"	
	#iperf -c $SERVER_IP -P 5
	iperf -c $SERVER_IP -u -b $BW -P 5 -t 10000
	echo ""
	sleep 3
done
