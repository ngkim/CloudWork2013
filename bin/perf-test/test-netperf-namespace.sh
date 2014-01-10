#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/openstack/netperf.sh"

# choose 'ovs' or 'sr-iov'
TEST_TYPE="ovs-netperf"

usage() {
	echo "Usage: $0 [MSG_SIZE]"
	echo "   ex) $0 16384"
}

if [ -z $1 ]; then
	usage; exit
fi

MSG_SIZE=$1

NODE_LIST[0]="50.50.1.17 50.50.1.4"
#NODE_LIST[1]="50.50.1.5 50.50.1.6"
#NODE_LIST[2]="50.50.1.7 50.50.1.8"
#NODE_LIST[3]="50.50.1.9 50.50.1.10"
#NODE_LIST[4]="50.50.1.11 50.50.1.12"
#NODE_LIST[5]="50.50.1.13 50.50.1.14"
#NODE_LIST[6]="50.50.1.15 50.50.1.16"
#NODE_LIST[7]="50.50.1.19 50.50.1.20"
#NODE_LIST[8]="50.50.1.21 50.50.1.22"
#NODE_LIST[9]="50.50.1.23 50.50.1.24"
#NODE_LIST[10]="50.50.1.25 50.50.1.26"
#NODE_LIST[11]="50.50.1.27 50.50.1.28"
#NODE_LIST[12]="50.50.1.39 50.50.1.40"
#NODE_LIST[13]="50.50.1.41 50.50.1.42"
#NODE_LIST[14]="50.50.1.49 50.50.1.50"
#NODE_LIST[15]="50.50.1.37 50.50.1.34"
#NODE_LIST[16]="50.50.1.45 50.50.1.48"
#NODE_LIST[17]="50.50.1.38 50.50.1.36"
#NODE_LIST[18]="50.50.1.35 50.50.1.33"
#NODE_LIST[19]="50.50.1.32 50.50.1.29"
#NODE_LIST[20]="50.50.1.31 50.50.1.30"
#NODE_LIST[21]="50.50.1.47 50.50.1.44"
#NODE_LIST[22]="50.50.1.17 50.50.1.43"
#NODE_LIST[23]="50.50.1.18 50.50.1.46"

MODE="netperf-namespace"

NAMESPACE=qrouter-ad4f6788-1bf9-4bef-84ae-d50645dcd124
SSH_KEY=test.pem
TEST_DURATION=30

NUM_NODES=${#NODE_LIST[@]}
LOG_DIR=$PWD/logs/$TEST_TYPE/$MSG_SIZE/$NUM_NODES
mkdir -p $LOG_DIR

#start_log_pps() {
#	IF=$1
#	PPS_LOG=$LOG_DIR/client.tcp.$CLIENT_IP-u-v.$SERVER_IP-pps.log
#	log_pps $IF &> $PPS_LOG &
#}

run_client() {
	SERVER_IP=$1
	CLIENT_IP=$2

	CLIENT_LOG=$LOG_DIR/client.tcp.$CLIENT_IP-u-v.$SERVER_IP.log

	print_info $MODE "Run netperf client at $CLIENT_IP"
	netperf_client_tcp $NAMESPACE $CLIENT_IP $SSH_KEY $SERVER_IP $CLIENT_LOG $TEST_DURATION $MSG_SIZE
}

for nodes in "${NODE_LIST[@]}"; do
	SERVER=`echo $nodes | awk '{print $1}'`
	CLIENT=`echo $nodes | awk '{print $2}'`
	run_client $SERVER $CLIENT
done

print_info $MODE "Wait for $TEST_DURATION seconds"
sleep $TEST_DURATION
sleep 3

$PWD/get-netperf-log.sh $TEST_TYPE $MSG_SIZE $NUM_NODES
