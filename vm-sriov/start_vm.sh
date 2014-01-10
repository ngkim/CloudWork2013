#!/bin/bash

usage() {
 	echo "Usage: $0 [VF_DEV_ID] [VNC_DISP]"
 	echo "   ex) $0 06:10.0 2" 
	echo ""
	lspci | grep --color 82599
	echo ""
}

VF_DEV_ID=$1
VNCDISPLAY=$2
if [ -z $VNCDISPLAY ]; then
	usage; exit -1
fi

IMAGE=image/precise-server-cloudimg-amd64-disk1.img
#IMAGE=precise-server-cloudimg-amd64-disk1-passwd.img
IMAGE_QCOW=ubuntu-server-img.qcow2
IMAGE_QCOW=ubuntu.qcow2

#IMAGE=disk.img
SEED=seed.img
SEED=seed.iso
# 211.224.204.141:5902
VNCDISPLAY=":$2"
MONITOR=/tmp/file-$VNCDISPLAY.mon
VM_LOG=/tmp/qemu-$VNCDISP.log

convert_image_raw2qcow2() {
	#qemu-img convert -O qcow2 precise-server-cloudimg-amd64-disk1.img disk.img.orig
	#qemu-img create -f qcow2 -b disk.img.orig disk.img

	qemu-img convert -f raw -O qcow2 \
	$IMAGE $IMAGE_QCOW
}

start_vm() {
	qemu-system-x86_64 -cpu host -m 4096 -smp 4 -boot c \
	-hda $IMAGE \
	-hdb $SEED \
	-device pci-assign,host=$VF_DEV_ID --enable-kvm \
	-nographic -vnc ${VNCDISPLAY} -monitor unix:${MONITOR},server,nowait
}

start_vm1() {
	qemu-system-x86_64 -cpu host -m 4096 -smp 4 -boot c \
	-hda $IMAGE_QCOW \
	-hdb $SEED \
	-device pci-assign,host=$VF_DEV_ID --enable-kvm \
	-nographic -vnc ${VNCDISPLAY} -monitor unix:${MONITOR},server,nowait
}

start_vm2() {
	qemu-system-x86_64 -m 4096 -smp 4 -boot c \
	-hda $IMAGE_QCOW \
	-device pci-assign,host=$VF_DEV_ID --enable-kvm \
	--nographic -vnc ${VNCDISPLAY}
}

start_test_vm() {
	qemu-system-x86_64 -machine accel=kvm:tcg -name instance-0000000b -S -M pc-i440fx-1.4 \
	-cpu Westmere,+rdtscp,+pdpe1gb,+dca,+pcid,+pdcm,+xtpr,+tm2,+est,+smx,+vmx,+ds_cpl,+monitor,+dtes64,+pclmuldq,+pbe,+tm,+ht,+ss,+acpi,+ds,+vme \
	-m 4096 -smp 2,sockets=2,cores=1,threads=1 -uuid 5727ce3a-8ce8-4263-a3fd-88fd3cd701ce \
	-smbios type=1,manufacturer=OpenStack Foundation,product=OpenStack Nova,version=2013.1,serial=37333336-3737-4e43-3731-343830475637,uuid=5727ce3a-8ce8-4263-a3fd-88fd3cd701ce \
	-no-user-config -nodefaults -chardev socket,id=charmonitor,path=/var/lib/libvirt/qemu/instance-0000000b.monitor,server,nowait \
	-mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc,driftfix=slew \
        -no-shutdown -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 \
	-drive file=/var/lib/nova/instances/5727ce3a-8ce8-4263-a3fd-88fd3cd701ce/disk,if=none,id=drive-virtio-disk0,format=qcow2,cache=none \
	-device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x4,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 \
	-netdev tap,fd=27,id=hostnet0,vhost=on,vhostfd=28 \
	-device virtio-net-pci,netdev=hostnet0,id=net0,mac=fa:16:3e:94:0a:cd,bus=pci.0,addr=0x3 \
	-mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc,driftfix=slew \
	-drive file=/var/lib/nova/instances/5727ce3a-8ce8-4263-a3fd-88fd3cd701ce/disk,if=none,id=drive-virtio-disk0,format=qcow2,cache=none \
	-chardev file,id=charserial0,path=/var/lib/nova/instances/5727ce3a-8ce8-4263-a3fd-88fd3cd701ce/console.log \
	-device isa-serial,chardev=charserial0,id=serial0 \
	-chardev pty,id=charserial1 \
	-device isa-serial,chardev=charserial1,id=serial1 \
	-device usb-tablet,id=input0 
	-vnc 0.0.0.0:1 
	-k en-us 
	-vga cirrus 
	-device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x5
}

start_simple_vm() {
	qemu-system-x86_64 -m 512 \
	-hda disk.img \
	-hdb my-seed.img \
	-net nic -net user -device pci-assign,host=$VF_DEV_ID \
	--nographic -vnc ${VNCDISPLAY} \
	--enable-kvm
}

start_vm3() {
	qemu-system-x86_64 -cpu host -m 1024 -smp 2 -boot c \
	-drive file=$IMAGE,if=virtio \
	-drive file=$SEED,if=virtio \
	-net nic -net user \
	-device pci-assign,host=$VF_DEV_ID --enable-kvm \
	-nographic -vnc ${VNCDISPLAY}
}

start_vm4() {
	# runs OK
	qemu-system-x86_64 -m 4096 -smp 4 -boot c \
	-hda $IMAGE \
	-net nic -net user --enable-kvm \
	--nographic -vnc ${VNCDISPLAY}
}

start_vm5() {
	# error
	qemu-system-x86_64 -m 4096 -smp 4 -boot c \
	-hda $IMAGE \
	-net nic -net user \
	-device pci-assign,host=$VF_DEV_ID --enable-kvm \
	--nographic -vnc ${VNCDISPLAY}
}

start_vm6() {
	# no pass-through
	qemu-system-x86_64 -m 4096 -smp 4 -boot c \
	-hda $IMAGE \
	-net nic -net user --enable-kvm \
	--nographic -vnc ${VNCDISPLAY}
}

generate_mac() {
	MAC=`openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'`
	echo $MAC
}

start_vm7() {
        # no pass-through
        qemu-system-x86_64 -m 4096 -smp 4 -boot c \
        -hda $IMAGE \
        -net nic -net user \
        -device pci-assign,host=$VF_DEV_ID --enable-kvm \
        --nographic -vnc ${VNCDISPLAY}
}

start_vm8() {
        # no pass-through
        qemu-system-x86_64 -m 4096 -smp 4 -boot c \
        -hda $IMAGE \
        -device pci-assign,host=$VF_DEV_ID --enable-kvm \
        --nographic -vnc ${VNCDISPLAY}
}

start_vm9() {
        # test if we can run  multiple instances - add daemonize
        qemu-system-x86_64 -m 4096 -smp 4 -boot c \
        -hda $IMAGE \
        -device pci-assign,host=$VF_DEV_ID \
	-daemonize --enable-kvm \
        -vnc ${VNCDISPLAY} \
 	-monitor unix:${MONITOR},server,nowait
}

start_vm10() {
    # remove monitor and add log - not working
    qemu-system-x86_64 -m 4096 -smp 4 -boot c \
    -hda $IMAGE \
    -net none \
    -device pci-assign,host=$VF_DEV_ID \
	-daemonize --enable-kvm \
    -vnc ${VNCDISPLAY}
	#-mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc,driftfix=slew \
	#-drive file=/var/lib/nova/instances/test/disk,if=none,id=drive-virtio-disk0,format=qcow2,cache=none \
	#-chardev file,id=charserial0,path=/var/lib/nova/instances/test/console.log
}

start_vm11() {
        # virtio device
        qemu-system-x86_64 -m 4096 -smp 4 -boot c \
        -hda $IMAGE \
        -device pci-assign,host=$VF_DEV_ID \
	-netdev tap,fd=27,id=hostnet0,vhost=on,vhostfd=28 \
	-device virtio-net-pci,netdev=hostnet0,id=net0,mac=fa:16:3e:7d:f6:00,bus=pci.0,addr=0x3 \
	-daemonize --enable-kvm \
        -vnc ${VNCDISPLAY} \
 	-D $VM_LOG
}

start_vm_bridge() {
        # virtio device
        qemu-system-x86_64 -m 4096 -smp 4 -boot c \
        -hda $IMAGE \
	-net nic -net tap,ifname=tap0 \
	--enable-kvm \
	--nographic -vnc ${VNCDISPLAY}
}

#echo "***** convert raw image to qcow2"
#convert_image_raw2qcow2
#echo "***** create cloud-localds"
#cloud-localds $SEED my-user-data
echo "***** start vm"
start_vm10
echo "***** done"
