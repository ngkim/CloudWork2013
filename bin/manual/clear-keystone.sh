#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/openstack/keystone.sh"
source "$MNG_ROOT/conf/n-node.conf"

MODE="CLEAR-KEYSTONE"

list_keystone() {
	print_info $MODE "tenant-list"
	keystone tenant-list | grep $TNAME
	
	print_info $MODE "user-list"
	keystone user-list | grep $UNAME
	
	print_info $MODE "user-role-list"
	keystone user-role-list | grep $UNAME
}

list_keystone
