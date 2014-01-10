#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/quantum.sh"
source "$MNG_ROOT/conf/n-node.conf"

MODE="CLEAR-NETWORK"

delete_network() {
	NAME=$1

	ID=$(get_network_id $NAME)
	if [ ! -z $ID ]; then
		print_warn $MODE "Delete network $ID"
		quantum net-delete $ID
	fi
}

delete_router() {
	NAME=$1

	ID=$(get_router_id $NAME)
	if [ ! -z $ID ]; then
		print_warn $MODE "Delete router $ID"
		quantum router-delete $ID
	fi
}

delete_subnet() {
	NAME=$1

	ID=$(get_subnet_id $NAME)
	if [ ! -z $ID ]; then
		print_warn $MODE "Delete subnet $ID"
		quantum subnet-delete $ID
	fi
}

list_networks() {
	print_info $MODE "net-list"
	quantum net-list

	print_info $MODE "subnet-list"
	quantum subnet-list

	print_info $MODE "router-list"
	quantum router-list

	print_info $MODE "port-list"
	quantum port-list
}

delete_networks() {
	RID=$(get_router_id $RNAME)
	SUBNET_ID=$(get_subnet_id $TENANT_SBNET_NAME)
	quantum router-interface-delete $RID $SUBNET_ID

	delete_router $RNAME

	delete_subnet $TENANT_SBNET_NAME
	
	delete_network $NNAME
	delete_network $EXT_NET_NAME
}

list_networks

delete_networks

list_networks

