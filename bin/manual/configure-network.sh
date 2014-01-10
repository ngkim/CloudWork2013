#!/bin/bash

source "$MNG_ROOT/include/openstack/config.sh"
source "$MNG_ROOT/include/openstack/install.sh"
source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/openstack/network.sh"

usage() {
	echo "* Update network configuration of a destination node"
 	echo "  - Usage: $0 [node-to-configure]"
	echo "  - To update network configuration of 'controller' node,"
    echo "    create '$MNG_ROOT/conf/controller.conf' and run following command"  
 	echo "  - ex) $0 controller" 
}

NODE=$1
if [ -z $NODE ]; then
	usage; exit -1
fi

NW_CONF=/tmp/interfaces

load_config $NODE
init_net_cfg $NW_CONF

if [ $EXT_CTRL_IF ]; then
	net_ext_ctrl $EXT_CTRL_IF $EXT_CTRL_IP $EXT_CTRL_MASK $EXT_CTRL_GW $EXT_CTRL_DNS
fi

if [ $INT_CTRL_IF ]; then
	net_int_ctrl $INT_CTRL_IF $INT_CTRL_IP
fi

# VM Network is configured only if NW_TYPE is gre
if [[ $INT_DATA_IF && $NW_TYPE = "gre" ]]; then
	net_int_data $INT_DATA_IF $INT_DATA_IP
fi

if [ $EXT_DATA_IF ]; then
	net_ext_data $EXT_DATA_IF
fi

print_info "NET-CONF" "Copy network configuration and restart networking service"
scp $NW_CONF $NODE:/etc/network/interfaces
ssh $NODE "service networking restart"

# if NW_TYPE is vlan, it will create an ovs bridge
if [[ $INT_DATA_IF && $NW_TYPE = "vlan" ]]; then
	modify_apt_source $NODE
	ssh $NODE apt-get update
	ssh $NODE apt-get install -y openvswitch-switch openvswitch-datapath-dkms
	net_int_data_br $INT_DATA_IF $NODE
fi



