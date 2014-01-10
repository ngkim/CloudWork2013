#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/util.sh"
source "$MNG_ROOT/include/openstack/config.sh"
source "$MNG_ROOT/include/openstack/configure.sh"

usage() {
 	echo "Usage: $0 [node-to-install]"
 	echo "   ex) $0 compute" 
}

NODE=$1
if [ -z $NODE ]; then
	usage; exit -1
fi

configure_packages() {
	load_config $NODE

	# NTP & IP Forward
	configure_ntp $SVC_NODE_INT_IP
	configure_ip_forward

	# Compute node
	configure_qemu
	configure_kvm
	configure_libvirt

	configure_ovs
	configure_quantum_agents compute

	configure_nova_compute compute
}

configure_packages
