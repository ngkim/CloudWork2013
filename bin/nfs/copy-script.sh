#!/bin/bash

source "$MNG_ROOT/include/print.sh"

HOST=$1

if [ -z $HOST ]; then
    echo "Usage: $0 [dest]"
    echo "   ex) $0 tst-goss4" 
    exit -1
fi

MODE="COPY-SCRIPT"
BIN_DIR=./bin

print_info $MODE "Config Auto Login"
ssh-copy-id $HOST

ssh $HOST "mkdir -p $BIN_DIR"

print_info $MODE "Copy init-env.sh"
scp init-env.sh $HOST:$BIN_DIR

print_info $MODE "Copy install-nfs-client.sh"
scp install-nfs-client.sh $HOST:$BIN_DIR

# copy /etc/hosts.allow and /etc/hosts.deny
./copy-tcpwrapper.sh $HOST

print_info $MODE  "Run init-env.sh at $HOST"
ssh $HOST $BIN_DIR/init-env.sh
sleep 3

print_info $MODE "Run install-nfs-client.sh at $HOST"
ssh $HOST $BIN_DIR/install-nfs-client.sh
sleep 3

print_info $MODE "Done!!!"
