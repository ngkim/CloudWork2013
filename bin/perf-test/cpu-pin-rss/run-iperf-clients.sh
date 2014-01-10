#!/bin/bash

T_EXP=20

run_iperf() {
	CPU_PIN=$1
	TARGET=$2
	T_PORT=$3

	LOG=/tmp/iperf-client-${CPU_PIN}-${T_PORT}.log
	rm $LOG
	taskset $CPU_PIN iperf -c $TARGET -p $T_PORT -i 1 -t $T_EXP &> $LOG  &
}

run_iperf 0x01 50.50.1.18 5001
run_iperf 0x02 50.50.1.18 5002
#run_iperf 0x04 50.50.1.18 5003
#run_iperf 0x08 50.50.1.18 5004

echo "Wait for $T_EXP seconds..."
sleep $T_EXP
echo "Done!!!"

#run_iperf 0x10 50.50.1.18 5005
#run_iperf 0x20 50.50.1.18 5006
#run_iperf 0x40 50.50.1.18 5007
#run_iperf 0x80 50.50.1.18 5008
