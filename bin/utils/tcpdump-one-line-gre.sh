#!/bin/bash

usage() {
	echo "Usage: $0 [DEV] [FILTER]"
	echo "   ex) $0 em2 src 10.20.20.51"
} 
	
if [ -z $1 ]; then
	usage; exit -1
fi

DEV=$1
FILTER=$(echo $@ | awk 'BEGIN{str = ""}{for (i = 1; i <= NF; i++) { if( i != 1) str = str" "$i }} END{print str}' | sed 's/^ //g')

echo "tcpdump -i $DEV -l -ne $FILTER"
#tcpdump -i $DEV -l -ne $FILTER | awk '{print $10, $11, $12, $13, $14, $28, $29, $32, $33, $34, $35, $36, $37, $38}' | sed 's/,//g'
tcpdump -i $DEV -l -ne $FILTER | awk '{print $10, $11, $12, $13, $14, $28, $29, $32, $33, $34, $35, $36, $37, $38}' 

