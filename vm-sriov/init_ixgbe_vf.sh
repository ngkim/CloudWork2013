#!/bin/bash -x

rmmod ixgbe
modprobe ixgbe max_vfs=63,63
lspci | grep 82599
