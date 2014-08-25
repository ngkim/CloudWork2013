#!/bin/bash

DEV_NAME=tap0

ip tuntap del dev $DEV_NAME mode tap vnet_hdr
