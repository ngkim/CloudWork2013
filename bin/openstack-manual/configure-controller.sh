#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/util.sh"
source "$MNG_ROOT/include/mysql.sh"
source "$MNG_ROOT/include/openstack/config.sh"
source "$MNG_ROOT/include/openstack/configure.sh"

NODE="controller"

configure_packages() {
	load_config $NODE

	# NTP & IP Forward
	configure_ntp $EXT_CTRL_IP
	configure_ip_forward

	# Mysql 	
	configure_mysql

	# Controller
	configure_keystone
	configure_glance
	configure_quantum_server
	configure_nova
	configure_cinder

	# Network
	configure_ovs
	configure_ovs_br_ex $EXT_DATA_IF
	configure_quantum_agents controller

	# Compute node
	configure_kvm
	configure_qemu
	configure_libvirt

	configure_nova_compute controller
}

configure_packages
