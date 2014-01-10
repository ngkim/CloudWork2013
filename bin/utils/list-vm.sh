#!/bin/bash

ps ax | grep qemu-system-x86_6[4] | awk '
BEGIN{ 
	printf("%-10s %-10s %-30s %-10s\n"," PID", " TYPE"," NAME"," VNC")
	printf("%-10s  %-10s %-30s %-10s\n","-----", "------","------------------------","------------")
}
{
	if (NF < 30) {
		printf(" %-10d %-10s %-30s %-10s\n",$1, "SR-IOV",$17,$21)
	} else { 
		printf(" %-10d %-10s %-30s %-10s\n",$1, "OVS",$9,$55)
	}
}'

#for vm in $VM_LIST; do
#	echo $vm
#done
