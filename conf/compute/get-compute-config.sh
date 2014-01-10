#!/bin/bash

CONFIG_FILES=`cat compute-config.list`

for f in $CONFIG_FILES; do
	echo $f
	scp compute:$f .
done
