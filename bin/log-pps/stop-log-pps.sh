#!/bin/bash

if [ -z $MNG_ROOT ]; then
	MNG_ROOT=$HOME/nfs-devstack
fi

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/netstat.sh"

stop_log_pps
