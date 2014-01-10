#!/bin/bash

source "$MNG_ROOT/include/print.sh"

NODE_LIST[0]="50.50.1.3"
NODE_LIST[1]="50.50.1.4"
NODE_LIST[2]="50.50.1.5" 
NODE_LIST[3]="50.50.1.6"
NODE_LIST[4]="50.50.1.7" 
NODE_LIST[5]="50.50.1.8"
NODE_LIST[6]="50.50.1.9" 
NODE_LIST[7]="50.50.1.10"
NODE_LIST[8]="50.50.1.11" 
NODE_LIST[9]="50.50.1.12"
NODE_LIST[10]="50.50.1.13" 
NODE_LIST[11]="50.50.1.14"
NODE_LIST[12]="50.50.1.15" 
NODE_LIST[13]="50.50.1.16"
NODE_LIST[14]="50.50.1.17" 
NODE_LIST[15]="50.50.1.18"

for node in "${NODE_LIST[@]}"; do
	print_info "LOG-PPS" "Prepare $node..."
	./prepare-log-pps.sh $node
done
