#!/bin/bash

run_iperf_server() {
	CPU_PIN=$1
	IPERF_PORT=$2

	taskset $CPU_PIN iperf -s -p $IPERF_PORT -i 1 &> /tmp/iperf-server-${CPU_PIN}-${IPERF_PORT}.log &
}

killall iperf
run_iperf_server 0x01 5001
run_iperf_server 0x02 5002
#run_iperf_server 0x04 5003
#run_iperf_server 0x08 5004
#run_iperf_server 0x10 5005
#run_iperf_server 0x20 5006
#run_iperf_server 0x40 5007
#run_iperf_server 0x80 5008
