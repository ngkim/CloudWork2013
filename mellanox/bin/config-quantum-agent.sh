#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/file.sh"

source "$MNG_ROOT/mellanox/conf/mlnx-quantum-agent.conf"

MODE="MLNX-Quantum-Agent-CFG"

Q_AGENT_CONF=$MLNX_Q_PLUG_HOME/mlnx_conf.ini

comment_and_insert_a_line $Q_AGENT_CONF \
						sql_connection \
						$STR_SQL

comment_and_insert_a_line $Q_AGENT_CONF \
						network_vlan_ranges \
						$STR_VLAN

comment_and_insert_a_line $Q_AGENT_CONF \
						physical_interface_mappings \
						$STR_MAP

comment_and_insert_a_line $Q_AGENT_CONF \
						vnic_type \
						$STR_VNIC

# Restart quantum-plugin-mellanox-agent service
service quantum-plugin-mellanox-agent restart
sleep 1

# Restart quantum services
restart-quantum.sh

