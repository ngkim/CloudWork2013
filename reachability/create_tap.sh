#!/bin/bash

DEV_NAME=tap0

ip tuntap add dev $DEV_NAME mode tap vnet_hdr
ip addr add 192.168.1.5/24 dev $DEV_NAME
ip link set $DEV_NAME up
