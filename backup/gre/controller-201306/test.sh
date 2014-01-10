#!/bin/bash

source "$MNG_ROOT/include/openstack/config.sh"

cp etc/keystone/keystone.conf /tmp/keystone.conf

load_config nz-compute
sed -i 's/10.10.10.51/'$INT_CTRL_IP'/g' /tmp/keystone.conf
