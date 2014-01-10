#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/util.sh"
source "$MNG_ROOT/include/mysql.sh"
source "$MNG_ROOT/include/openstack/config.sh"
source "$MNG_ROOT/include/openstack/install.sh"

NODE="controller"

install_controller_packages() {
	load_config $NODE

	modify_apt_source
	apt_get_update

	add_grizzly_repo

	install_package "NTP" ntp

	install_package "RabbitMQ" rabbitmq-server
	install_mysql $MYSQL_ADMIN_PASS

	install_package "Keystone" keystone
	install_package "Glance" glance 
	install_package "Quantum-Server" quantum-server
	install_quantum_components

	install_nova
	install_cinder
	install_horizon

	install_kvm
	install_libvirt

	install_ovs
	install_quantum_ovs_agent
	install_package "Nova-Compute" nova-compute-kvm

	install_ethtool
}

install_controller_packages
