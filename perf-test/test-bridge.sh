#!/bin/bash

source "$MNG_ROOT/include/print.sh"

usage() {
 	echo "Usage: $0 [openstack/ovs/linux]"
 	echo "   ex) $0 ovs" 
}

MODE=$1
if [ -z $MODE ]; then
	usage; exit -1
fi

VM_ID_LIST="47061a45-33 e31bc469-d1"
#OVS_BR=br-test
OVS_BR=br-int
LINUX_BR=br0

add_vm_to_ovs_br() {
	for VM_ID in $VM_ID_LIST; do
		ovs-vsctl add-port $OVS_BR tap$VM_ID
	done
}

del_vm_from_ovs_br() {
	for VM_ID in $VM_ID_LIST; do
		ovs-vsctl del-port $OVS_BR tap$VM_ID
	done
}

add_vm_to_openstack_br() {
	for VM_ID in $VM_ID_LIST; do
		brctl addif qbr$VM_ID tap$VM_ID
	done
}

del_vm_from_openstack_br() {
	for VM_ID in $VM_ID_LIST; do
		brctl delif qbr$VM_ID tap$VM_ID
	done
}

add_vm_to_linux_br() {
	for VM_ID in $VM_ID_LIST; do
		brctl addif $LINUX_BR tap$VM_ID
	done
}

del_vm_from_linux_br() {
	for VM_ID in $VM_ID_LIST; do
		brctl delif $LINUX_BR tap$VM_ID
	done
}

add_veth_to_ovs_br() {
	for VM_ID in $VM_ID_LIST; do
		ovs-vsctl add-port $OVS_BR qvo$VM_ID
	done
}

del_veth_from_ovs_br() {
	for VM_ID in $VM_ID_LIST; do
		ovs-vsctl del-port $OVS_BR qvo$VM_ID
	done
}

set_veth_mtu() {
	_MTU=$1
	for VM_ID in $VM_ID_LIST; do
		ifconfig qvo$VM_ID mtu $_MTU
		ifconfig qvb$VM_ID mtu $_MTU
	done
}

add_linux_br() {
	brctl addbr $LINUX_BR
	ifconfig $LINUX_BR up
}

del_linux_br() {
	ifconfig $LINUX_BR down
	brctl delbr $LINUX_BR
}

clear_bridge_iptables() {
	sysctl net.bridge.bridge-nf-call-iptables=0
}

ifstat_vm_interfaces() {
	TAP_LIST=$(echo $VM_ID_LIST | sed 's/ /,/')
	echo $TAP_LIST
	ifstat -b -i $TAP_LIST
}

show_br() {
	MODE=$1

	print_info "BRIDGES" "List of ports"
	if [ $MODE = "openstack" ]; then
		for VM_ID in $VM_ID_LIST; do
			brctl show qbr$VM_ID
		done
	elif [ $MODE = "ovs" ]; then
		ovs-vsctl list-ports $OVS_BR
	elif [ $MODE = "linux" ]; then
		brctl show $LINUX_BR
	fi
}

if [ $MODE = "openstack" ]; then
	del_vm_from_ovs_br
	del_vm_from_linux_br
	add_vm_to_openstack_br
	set_veth_mtu 1504
elif [ $MODE = "ovs" ]; then
	del_vm_from_openstack_br
	del_vm_from_linux_br
	add_vm_to_ovs_br
elif [ $MODE = "linux" ]; then
	del_vm_from_openstack_br
	del_vm_from_ovs_br
	add_vm_to_linux_br
else
	usage; exit -1
fi

show_br $MODE
