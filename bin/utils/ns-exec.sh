#!/bin/bash

usage() {
	echo "Usage: $0 [commands-to-run]"
	echo "   ex) $0 ip addr list"
}

if [ -z $1 ]; then
	usage; exit -1
fi

echo $@
ip netns exec qrouter-5b439871-99bb-49dc-8ca1-45550431fafc $@
