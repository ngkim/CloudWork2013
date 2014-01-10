#!/bin/bash

SHELL_CONF=$HOME/.bashrc

cat <<EOF | tee -a $SHELL_CONF
export MNG_ROOT=\$HOME/nfs-devstack
export PATH=\$PATH:\$MNG_ROOT/bin/nfs:\$MNG_ROOT/bin/nova-manage:\$MNG_ROOT/bin/manual
EOF
