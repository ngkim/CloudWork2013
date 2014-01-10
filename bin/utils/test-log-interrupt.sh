#!/bin/bash

source "$MNG_ROOT/include/mpstat.sh"

_RUN_STAT_FILE=/tmp/.run_mpstat

echo "1" > $_RUN_STAT_FILE

log_stat p1p-TxRx-0 
