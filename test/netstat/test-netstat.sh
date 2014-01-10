#!/bin/bash

source "$MNG_ROOT/include/netstat.sh"


LOG_PPS="/tmp/test-pps.log"

start_log_pps p1p1 $LOG_PPS

sleep 10

stop_log_pps 
