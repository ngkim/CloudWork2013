#/bin/bash

source "$MNG_ROOT/include/util.sh"
source "$MNG_ROOT/include/print.sh"

usage() {
 	echo "Usage: $0 [target-node]"
 	echo "   ex) $0 controller" 
}

NODE=$1
if [ -z $NODE ]; then
	usage; exit -1
fi

MODE=BACKUP-$NODE

print_info $MODE "/etc"
mkdir -p etc
scp -r root@$NODE:/etc/hosts etc/
scp -r root@$NODE:/etc/ntp.conf etc/
scp -r root@$NODE:/etc/sysctl.conf etc/

print_info $MODE "/etc/apt"
mkdir -p etc/apt
scp -r root@$NODE:/etc/apt/sources.list etc/apt/
scp -r root@$NODE:/etc/apt/sources.list.d etc/apt/

print_info $MODE "/etc/network"
mkdir -p etc/network
scp -r root@$NODE:/etc/network/interfaces etc/network

print_info $MODE "/etc/default"
mkdir -p etc/default
scp -r root@$NODE:/etc/default etc/

print_info $MODE "/etc/init.d"
mkdir -p etc/init.d
scp -r root@$NODE:/etc/init.d etc/

print_info $MODE "/etc/mysql"
mkdir -p etc/mysql
scp -r root@$NODE:/etc/mysql etc/

print_info $MODE "/etc/keystone"
mkdir -p etc/keystone
scp -r root@$NODE:/etc/keystone etc/

print_info $MODE "/etc/glance"
mkdir -p etc/glance
scp -r root@$NODE:/etc/glance etc/

print_info $MODE "/etc/cinder"
mkdir -p etc/cinder
scp -r root@$NODE:/etc/cinder etc/

print_info $MODE "/etc/libvirt"
mkdir -p etc/libvirt
scp -r root@$NODE:/etc/libvirt etc/

print_info $MODE "/etc/nova"
mkdir -p etc/nova
scp -r root@$NODE:/etc/nova etc/

print_info $MODE "/etc/quantum"
mkdir -p etc/quantum
scp -r root@$NODE:/etc/quantum etc/

print_info $MODE "/etc/eswitchd"
mkdir -p etc/eswitchd
scp -r root@$NODE:/etc/eswitchd etc/
