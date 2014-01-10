#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/openstack/iperf.sh"

MODE=$1
NUM_NODES=$2

usage() {
        echo "Usage: $0 [MODE] [NUM_NODES]"
        echo "   ex) $0 sr-iov 2" 
		echo "   MODE= ovs or sr-iov"
}

if [ -z $NUM_NODES ]; then
	usage; exit -1
fi

LOG_DIR=$PWD/logs/$MODE/$NUM_NODES

analyze_iperf_log $LOG_DIR tcp

