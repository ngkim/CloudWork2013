#!/bin/bash

CONFIG_FILES=`cat compute-config.list`
CONFIG_FILE=compute-config.list

#for f in $CONFIG_FILES; do
#	echo $f
	#SRC=`echo $f | awk '{print $1}'`
	#DST=`echo $f | awk '{print $2}'`
	#scp compute:$f .
	#echo "$SRC ==> $DST"
#done

DST_HOST=$1

while read line           
do           
	SRC=`echo $line | awk '{print $1}'`
	DST=`echo $line | awk '{print $2}'`

	echo "$SRC ==> $DST"
	scp $SRC $DST_HOST:$DST
done < $CONFIG_FILE
