#!/bin/bash -x

rmmod ixgbe
modprobe ixgbe
lspci | grep 82599
