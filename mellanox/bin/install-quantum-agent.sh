#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/file.sh"

source "$MNG_ROOT/mellanox/conf/mlnx-quantum-agent.conf"

MODE="MLNX-Quantum-Agent-INSTALL"

# 1.Copy mellanox Quantum Agent source files
Q_AGENT_SRC_ORIG=$MLNX_Q_AGENT_HOME/quantum/plugins/mlnx
Q_AGENT_SRC=$PYLIB_ROOT/quantum/plugins

print_info $MODE "Copy mellanox quantum agent source files..."
cp -a $Q_AGENT_SRC_ORIG $Q_AGENT_SRC

# 2.Copy mellanox Quantum Agent source files

Q_AGENT_CONF_ORIG=$MLNX_Q_AGENT_HOME/etc/quantum/plugins/mlnx/mlnx_conf.ini
Q_AGENT_CONF=$MLNX_Q_PLUG_HOME/mlnx_conf.ini

print_info $MODE "Copy mellanox quantum agent config files..."
mkdir -p $MLNX_Q_PLUG_HOME
cp $Q_AGENT_CONF_ORIG $MLNX_Q_PLUG_HOME

TARGET=/etc/init/quantum-plugin-mellanox-agent.conf
print_info $MODE "Copy quantum-plugin-mellanox-agent.conf to $TARGET"
cp $MLNX_Q_AGENT_HOME/$TARGET $TARGET

TARGET=/etc/init.d/quantum-plugin-mellanox-agent
print_info $MODE "Copy quantum-plugin-mellanox-agent to $TARGET"
cp $MLNX_Q_AGENT_HOME/$TARGET $TARGET

TARGET=/usr/bin/quantum-mellanox-agent
print_info $MODE "Copy quantum-mellanox-agent to $TARGET"
cp $MLNX_Q_AGENT_HOME/$TARGET $TARGET



