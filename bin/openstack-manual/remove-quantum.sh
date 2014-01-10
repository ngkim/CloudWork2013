#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/quantum.sh"
source "$MNG_ROOT/conf/n-node.conf"

MODE="RESET-QUANTUM"

MYSQL_ADMIN="root"
MYSQL_ADMIN_PASS="ohhberry3333"
DATABASE=quantum

uninstall_quantum_agent() {
	apt-get -y purge quantum-plugin-openvswitch-agent 
	apt-get -y purge quantum-dhcp-agent 
	apt-get -y purge quantum-l3-agent 
	apt-get -y purge quantum-metadata-agent

	rm -rf /etc/quantum/plugins/openvswitch

	mysql -u $MYSQL_ADMIN -p$MYSQL_ADMIN_PASS $DATABASE -e "delete from agents where host = 'tst-goss6.tst-goss6';"

	iptables -F
	iptables -t nat -F
}

uninstall_quantum_agent
