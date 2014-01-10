#!/bin/bash

source "$MNG_ROOT/include/print.sh"

MODE="NOVA-CREATE-VM"

print_    Add this security rules to make your VMs pingable:

    nova --no-cache secgroup-add-rule default icmp -1 -1 0.0.0.0/0
    nova --no-cache secgroup-add-rule default tcp 22 22 0.0.0.0/0

    Start by allocating a floating ip to the project one tenant:

    quantum floatingip-create ext_net

    Start a VM:

    nova --no-cache boot --image $id_myFirstImage --flavor 1 my_first_vm

    pick the id of the port corresponding to your VM:

    quantum port-list

    Associate the floating IP to your VM:

    quantum floatingip-associate $put_id_floating_ip $put_id_vm_port

