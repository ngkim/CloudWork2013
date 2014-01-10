#!/bin/bash

source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/file.sh"

source "$MNG_ROOT/mellanox/conf/mlnx-nova.conf"

MODE="MLNX-NOVA-CFG"

NOVA_CONF=/etc/nova/nova.conf

comment_and_insert_a_line $NOVA_CONF \
						compute_driver \
						$STR_C_DRIVER

insert_a_line $NOVA_CONF \
						^compute_driver \
						$STR_VNIC

insert_a_line $NOVA_CONF \
						^compute_driver \
						$STR_FABRIC

comment_and_insert_a_line $NOVA_CONF \
						libvirt_vif_driver \
						$STR_V_DRIVER

# Restart nova services
restart-nova.sh

