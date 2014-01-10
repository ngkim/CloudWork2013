#!/bin/bash

source "$MNG_ROOT/include/netstat.sh"

IFACE=p1p1
LOG_PPS="/tmp/test-pps.log"

get_avg_pps $IFACE $LOG_PPS 1
