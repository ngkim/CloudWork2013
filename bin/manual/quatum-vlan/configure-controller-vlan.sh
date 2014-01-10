#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/util.sh"
source "$MNG_ROOT/include/mysql.sh"
source "$MNG_ROOT/include/openstack/configure.sh"

########################################
EXT_CTRL_IP=211.224.204.141
INT_CTRL_IP=10.10.10.51
INT_DATA_IP=10.20.20.51
EXT_DATA_IF=em4

MYSQL_ADMIN="root"
MYSQL_ADMIN_PASS="ohhberry3333"
########################################

configure_packages() {
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
