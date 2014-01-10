#!/bin/bash

usage() {
	echo "Usage: $0 [NAME] [SERVER]"
	echo "   ex) $0 test-server oz-controller"
	exit	
}

if [ -z $2 ]; then
	usage;
fi

_NAME=$1
_SERVER=$2

IMAGE="ubuntu-server-12.04"

nova_boot_force_hosts() {
    nova boot \
        --image $IMAGE \
        --flavor 2 \
        --hint force_hosts=$_SERVER \
        $_NAME
}

nova_boot_zone() {
    nova boot \
        --image $IMAGE \
        --flavor 2 \
        --availability-zone nova:$_SERVER \
        $_NAME
}

nova_boot_zone
