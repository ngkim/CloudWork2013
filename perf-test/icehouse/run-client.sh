#!/bin/bash

source "$MNG_ROOT/include/print.sh"

usage() {
	echo "Usage: $0 [SERVER_IP] [NUM_ITERATION]"
	echo " ex) $0 192.168.51.2 3"
	exit 0
}

if [ -z "$2" ]; then 
	usage
fi

MODE="PERF-TEST"
SERVER_IP=$1
NUM_ITERATION=$2

for i in `seq 1 $NUM_ITERATION`; do
	print_info $MODE "$i ---"	
	iperf -c $SERVER_IP -P 5
	echo ""
	sleep 3
done
