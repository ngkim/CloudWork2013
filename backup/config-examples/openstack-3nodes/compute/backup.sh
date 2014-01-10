#/bin/bash

#NODE="210.183.241.161"
#NODE="210.183.241.162"
NODE="210.183.241.163"

mkdir -p etc
scp -r root@$NODE:/etc/hosts etc/
scp -r root@$NODE:/etc/ntp.conf etc/
scp -r root@$NODE:/etc/sysctl.conf etc/

mkdir -p etc/network
scp -r root@$NODE:/etc/network/interfaces etc/network

mkdir -p etc/default
scp -r root@$NODE:/etc/default etc/

mkdir -p etc/libvirt
scp -r root@$NODE:/etc/libvirt etc/

mkdir -p etc/mysql
scp -r root@$NODE:/etc/mysql etc/

mkdir -p etc/keystone
scp -r root@$NODE:/etc/keystone etc/

mkdir -p etc/glance
scp -r root@$NODE:/etc/glance etc/

mkdir -p etc/nova
scp -r root@$NODE:/etc/nova etc/

mkdir -p etc/cinder
scp -r root@$NODE:/etc/cinder etc/

mkdir -p etc/quantum
scp -r root@$NODE:/etc/quantum etc/

mkdir -p etc/apt
scp -r root@$NODE:/etc/apt/sources.list.d etc/apt/


