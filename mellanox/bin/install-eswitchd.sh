#!/bin/bash

source "$MNG_ROOT/include/print.sh"

source "$MNG_ROOT/mellanox/conf/mlnx-eswitchd.conf"

MODE="MLNX-ESWITCH-INSTALL"

print_info $MODE "Install eswitchd"
git clone https://github.com/mellanox-openstack/mellanox-eswitchd
cd mellanox-eswitchd
python setup.py install 
sleep 3
rm -rf mellanox-eswitchd

print_info $MODE "Copy eswitchd.conf to $ESWITCH_CFG_HOME"
mkdir -p $ESWITCH_CFG_HOME
cp $MLNX_ESWITCH_HOME/etc/eswitchd/eswitchd.conf $ESWITCH_CFG_HOME

print_info $MODE "Copy eswitchd.conf to /etc/init"
cp $MLNX_ESWITCH_HOME/etc/init/eswitchd.conf /etc/init

print_info $MODE "Copy eswitchd to /etc/init.d"
cp $MLNX_ESWITCH_HOME/etc/init.d/eswitchd /etc/init.d

