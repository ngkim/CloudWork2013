#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/util.sh"
source "$MNG_ROOT/include/openstack/install.sh"

install_packages() {
	modify_apt_source

	add_grizzly_repo
	apt_get_update

	install_package "NTP" ntp
	install_vlan
	install_ethtool

	install_kvm
	install_libvirt

	install_ovs
	install_quantum_ovs_agent
	install_package "Nova-Compute" nova-compute-kvm
}

install_packages
