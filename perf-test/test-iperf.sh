#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/iperf.sh"

NODE_LIST[0]="10.10.30.3 10.10.30.4"
#NODE_LIST[1]="10.10.30.5 10.10.30.6"
#NODE_LIST[2]="10.10.30.7 10.10.30.8"
#NODE_LIST[3]="10.10.30.9 10.10.30.10"
#NODE_LIST[4]="10.10.30.11 10.10.30.12"
#NODE_LIST[5]="10.10.30.13 10.10.30.14"
#NODE_LIST[6]="10.10.30.15 10.10.30.16"
#NODE_LIST[7]="10.10.30.19 10.10.30.20"
#NODE_LIST[8]="10.10.30.21 10.10.30.22"
#NODE_LIST[9]="10.10.30.23 10.10.30.24"
#NODE_LIST[10]="10.10.30.25 10.10.30.26"
#NODE_LIST[11]="10.10.30.27 10.10.30.28"
#NODE_LIST[12]="10.10.30.39 10.10.30.40"
#NODE_LIST[13]="10.10.30.41 10.10.30.42"
#NODE_LIST[14]="10.10.30.49 10.10.30.50"
#NODE_LIST[15]="10.10.30.37 10.10.30.34"
#NODE_LIST[16]="10.10.30.45 10.10.30.48"
#NODE_LIST[17]="10.10.30.38 10.10.30.36"
#NODE_LIST[18]="10.10.30.35 10.10.30.33"
#NODE_LIST[19]="10.10.30.32 10.10.30.29"
#NODE_LIST[20]="10.10.30.31 10.10.30.30"
#NODE_LIST[21]="10.10.30.47 10.10.30.44"
#NODE_LIST[22]="10.10.30.17 10.10.30.43"
#NODE_LIST[23]="10.10.30.18 10.10.30.46"

MODE="iperf-SRIOV"
TEST_DURATION=30

NUM_NODES=${#NODE_LIST[@]}
LOG_DIR=$PWD/logs/sr-iov/$NUM_NODES
mkdir -p $LOG_DIR

run_server() {
	SERVER_IP=$1
	CLIENT_IP=$2

	SERVER_LOG=$LOG_DIR/server.tcp.$CLIENT_IP-u-v.$SERVER_IP.log
	CLIENT_LOG=$LOG_DIR/client.tcp.$CLIENT_IP-u-v.$SERVER_IP.log

	print_info $MODE "Kill remaining iperf server process at $SERVER_IP"
	kill_iperf $SERVER_IP

	print_info $MODE "Start iperf server at $SERVER_IP"
	iperf_server_tcp $SERVER_IP $SERVER_LOG
	sleep 1
}

run_client() {
	SERVER_IP=$1
	CLIENT_IP=$2

	SERVER_LOG=$LOG_DIR/server.tcp.$CLIENT_IP-u-v.$SERVER_IP.log
	CLIENT_LOG=$LOG_DIR/client.tcp.$CLIENT_IP-u-v.$SERVER_IP.log

	print_info $MODE "Run iperf client at $CLIENT_IP"
	iperf_client_tcp $CLIENT_IP $SERVER_IP $CLIENT_LOG $TEST_DURATION
}

for nodes in "${NODE_LIST[@]}"; do
	SERVER=`echo $nodes | awk '{print $1}'`
	CLIENT=`echo $nodes | awk '{print $2}'`
	run_server $SERVER $CLIENT
done
sleep 3

for nodes in "${NODE_LIST[@]}"; do
	SERVER=`echo $nodes | awk '{print $1}'`
	CLIENT=`echo $nodes | awk '{print $2}'`
	run_client $SERVER $CLIENT
done

print_info $MODE "Wait for $TEST_DURATION seconds"
sleep $TEST_DURATION
sleep 3

$PWD/get-iperf-log.sh sr-iov $NUM_NODES
