#!/bin/bash

get_iperf_log() {
	CPU_PIN=$1
	T_PORT=$2

	LOG=/tmp/iperf-client-${CPU_PIN}-${T_PORT}.log
	tail -n 1 $LOG
}

get_throughput() {
	CPU_PIN=$1
	T_PORT=$2

	VAL=`get_iperf_log $CPU_PIN $T_PORT`
	VAL=`echo $VAL | awk '{print $7}'`
	echo $VAL
}


VAL1=`get_throughput 0x01 5001`
VAL2=`get_throughput 0x02 5002`
#VAL3=`get_throughput 0x04 5003`
#VAL4=`get_throughput 0x08 5004`

SUM=`expr $VAL1 + $VAL2`
#SUM=`expr $SUM + $VAL3`
#SUM=`expr $SUM + $VAL4`

echo $SUM
