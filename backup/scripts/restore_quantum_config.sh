#!/bin/bash

CONFIG_FILES="config.list"

DST_HOST="controller"

while read line
do
	SRC_CFG=$line
	DST_CFG="/"$line

	scp $SRC_CFG $DST_HOST:$DST_CFG
done <$CONFIG_FILES


