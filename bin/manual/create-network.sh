#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/openstack/keystone.sh"
source "$MNG_ROOT/include/openstack/quantum.sh"
source "$MNG_ROOT/conf/n-node.conf"

get_id () {
    echo `"$@" | awk '/ id / { print $4 }'`
}

#print_info $MODE "Load admin credential..."
#source $MNG_ROOT/creds/admin-openrc.sh
print_info $MODE "Create a new tenant"
TID=$(create_tenant $TNAME)

echo "TENANT= $TID"
print_info $MODE "Create a new user and assign the member role to it in the new tenant"
create_user_in_tenant $UNAME $UPASS $TID $EMAIL

print_info $MODE "Create a new network for the tenant"
create_tenant_network $TID $NNAME

print_info $MODE "Create a new subnet inside the new tenant network"
TENANT_SBNET_ID=$(create_tenant_subnet $TID $TENANT_SBNET_NAME $NNAME $TENANT_SBNET)
print_info $MODE "TENANT_SBNET_ID= $TENANT_SBNET_ID"

print_info $MODE "Create a router for the new tenant= $TID RNAME= $RNAME"
RID=$(create_router $TID $RNAME)
print_info $MODE "ROUTERID= $RID"
add_router_to_l3_agent $RNAME

print_info $MODE "Add the router to the subnet: ROUTERID= $RID SBNET_ID= $TENANT_SBNET_ID"
add_router_to_subnet $RID $TENANT_SBNET_ID

print_info $MODE "Restart Quantum..."
restart_quantum

print_info $MODE "Create an external network with the tenant id belonging to the admin tenant:"
ADMIN_TID=$(get_tenant_id admin)
EXT_NET_ID=$(create_ext_net $ADMIN_TID $EXT_NET_NAME )

print_info $MODE "Create a subnet for the floating ips:"
create_floating_ip_subnet $ADMIN_TID $FLOAT_START $FLOAT_END $EXT_NET_GW $EXT_NET_NAME $EXT_SBNET_MASK

print_info $MODE "Set your router's gateway to the external network:"
set_router_gateway $RID $EXT_NET_ID

