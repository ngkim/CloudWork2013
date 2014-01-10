#!/bin/bash

source "$MNG_ROOT/include/print.sh"

usage() {
 	echo "Usage: $0 [net-type] [node-to-restore]"
	echo "   [net-type]: gre-tunnel or vlan-mode"
 	echo "   ex) $0 gre-tunnel controller" 
}

TYPE=$1
NODE=$2
if [ -z $NODE ]; then
	usage; exit -1
fi

MODE=RESTORE-$NODE

print_info $MODE "/etc/nova"
scp -r $TYPE/$NODE/etc/nova root@$NODE:/etc
ssh $NODE "cd /etc/init.d; for i in `ls nova*`; do service $i restart; done; cd -"

print_info $MODE "/etc/quantum"
scp -r $TYPE/$NODE/etc/quantum root@$NODE:/etc
ssh $NODE "cd /etc/init.d; for i in `ls quantum*`; do service $i restart; done; cd -"


