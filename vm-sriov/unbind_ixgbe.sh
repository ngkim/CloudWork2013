#!/bin/bash

source "$MNG_ROOT/include/print.sh"

usage() {
 	echo "Usage: $0 [VF_DEV_ID]"
 	echo "   ex) $0 06:10.0" 
}

MODE="UNBIND-VF"

VF_DEV_ID=$1
if [ -z $VF_DEV_ID ]; then
	usage; exit -1
fi

print_info $MODE "lspci $VF_DEV_ID"
lspci | grep $VF_DEV_ID

VF_DEV_ID="0000:$VF_DEV_ID"
modprobe pci-stub

print_info $MODE "Unbind $VF_DEV_ID"
print_info $MODE "- 1) pci-stub/new_id"
echo "8086 10ed" > /sys/bus/pci/drivers/pci-stub/new_id
print_info $MODE "- 2) driver/unbind"
echo $VF_DEV_ID > /sys/bus/pci/devices/$VF_DEV_ID/driver/unbind
print_info $MODE "- 3) bind"
echo $VF_DEV_ID > /sys/bus/pci/drivers/pci-stub/bind
print_info $MODE "- 4) pci-stub/remove_id"
echo "8086 10ed" > /sys/bus/pci/drivers/pci-stub/remove_id
