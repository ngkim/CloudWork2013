#!/bin/bash

source "$MNG_ROOT/include/vmstat.sh"

LOG_VMSTAT="/tmp/test-vmstat.log"

rm -rf $LOG_VMSTAT
start_log_vmstat $LOG_VMSTAT

sleep 10

stop_log_vmstat

get_cpu_usage $LOG_VMSTAT
sleep 3
get_intr_ctxt $LOG_VMSTAT
