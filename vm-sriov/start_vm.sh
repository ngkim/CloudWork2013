#!/bin/bash


VM_IMAGE_LIST[0]="ubuntu_12.04_default_ixgbevf"
VM_IMAGE_LIST[1]="ubuntu_13.04_default_ixgbevf"
VM_IMAGE_LIST[2]="ubuntu_12.04_latest_ixgbevf"
VM_IMAGE_LIST[3]="ubuntu_13.04_latest_ixgbevf"
VM_IMAGE_LIST[4]="ubuntu_13.04_nginx"
VM_IMAGE_LIST[5]="ubuntu_13.04_nginx_latest_ixgbevf"
VM_IMAGE_LIST[6]="centos_6.4_nginx_src"
VM_IMAGE_LIST[7]="ubuntu_12.04_nginx_jmeter"

usage() {
 	echo "Usage: $0 [VF_DEV_ID] [VNC_DISP] [VM_OS_IMAGE]"
 	echo "   ex) $0 06:10.0 2 1" 

	itr_count=0
	for vm_image in "${VM_IMAGE_LIST[@]}"; do
		echo "    $itr_count : $vm_image"
		itr_count=`expr $itr_count + 1`
	done
	#echo ""
	#lspci | grep --color 82599
	#echo ""
}

VF_DEV_ID=$1
VNCDISPLAY=$2
VM_IMAGE=$3
if [ -z $3 ]; then
	usage; exit -1
fi

if [ $3 -ge ${#VM_IMAGE_LIST[@]} ]; then
	usage; exit -1
fi

SRC_IMAGE=image/${VM_IMAGE_LIST[$VM_IMAGE]}
IMAGE=image/instances/${VM_IMAGE_LIST[$VM_IMAGE]}-$RANDOM
MEM_SIZE=4096
NUM_CPU=4

echo "Copy $SRC_IMAGE to $IMAGE"
cp $SRC_IMAGE $IMAGE

# 211.224.204.141:5902
VNCDISPLAY=":$2"

start_vm10() {
    # remove monitor and add log - not working
    qemu-system-x86_64 -m $MEM_SIZE -smp $NUM_CPU -boot c \
    -hda $IMAGE \
    -net none \
    -device pci-assign,host=$VF_DEV_ID \
    -daemonize --enable-kvm \
    -vnc ${VNCDISPLAY}
}

echo "***** start vm"
start_vm10
echo "***** done"
