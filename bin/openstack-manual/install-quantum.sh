#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/quantum.sh"
source "$MNG_ROOT/conf/n-node.conf"

MODE="RESET-QUANTUM"

MYSQL_ADMIN="root"
MYSQL_ADMIN_PASS="ohhberry3333"
DATABASE=quantum

install_quantum_agent() {
	apt-get -y install quantum-plugin-openvswitch-agent 
	apt-get -y install quantum-dhcp-agent 
	apt-get -y install quantum-l3-agent 
	apt-get -y install quantum-metadata-agent
}

install_quantum_agent
