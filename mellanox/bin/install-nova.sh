#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/file.sh"

source "$MNG_ROOT/mellanox/conf/mlnx-nova.conf"

MODE="MLNX-NOVA-INSTALL"

VIF_SRC_ORIG=$MLNX_PLUGIN_SRC/nova/nova/virt/libvirt/mlnx
VIF_SRC=$PYLIB_ROOT/nova/virt/libvirt

print_info $MODE "Copy mellanox VIF source files..."
cp -a $VIF_SRC_ORIG $VIF_SRC

