#!/bin/bash

NFS_SERVER=211.224.204.158
NFS_FOLDER=/root/nfs-devstack
FSTAB_CONF=/etc/fstab

print_msg() {
    MSG=$1
    echo "*** $MSG ***"
}

modify_apt_source() {
	_HOST=$1

	# change apt-source to kr.archive.ubuntu.com
	if [ -z $_HOST ]; then
    	sed -i 's/us.archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list
    	sed -i 's/kr.archive.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list
	else
    	ssh $_HOST "sed -i 's/us.archive.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list"
    	ssh $_HOST "sed -i 's/kr.archive.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list"
	fi
}

print_msg "RUN apt-get update"
modify_apt_source
apt-get update 

print_msg "Install NFS Client"
apt-get -y install nfs-common language-pack-en language-pack-ko
sleep 1

print_msg "Create NFS directory"
mkdir -p nfs-devstack

print_msg "Mount NFS directory"
mount -v -t nfs4 $NFS_SERVER:/ $NFS_FOLDER

print_msg "Add configuration to $FSTAB_CONF"

cat <<EOF | tee -a $FSTAB_CONF
$NFS_SERVER:/       $NFS_FOLDER      nfs     auto    0       0
EOF


