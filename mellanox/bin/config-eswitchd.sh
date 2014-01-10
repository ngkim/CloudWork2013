#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/file.sh"

source "$MNG_ROOT/mellanox/conf/mlnx-eswitchd.conf"

MODE="MLNX-ESWITCH-CONFIG"

ESWITCH_CFG_FILE=$ESWITCH_CFG_HOME/eswitchd.conf

print_info $MODE "Update $ESWITCH_CFG_FILE"
comment_and_insert_a_line $ESWITCH_CFG_FILE \
                        fabrics \
                        $STR_FABRIC

print_info $MODE "Restart eswitchd..."
service eswitchd restart
