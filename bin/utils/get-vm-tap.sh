#!/bin/bash

usage() {
	echo "Usage: $0 [VM INSTANCE ID]"
	echo "   ex) $0 instance-00000116"
}

if [ -z $1 ]; then
	usage; exit -1
fi
VMID=$1

virsh dumpxml $VMID | grep "target dev='tap"

