#!/bin/bash

BACKUP_DATE=`date +%Y%m%d%H%M`
BACKUP_DIR="backup/$BACKUP_DATE"

echo "*** LOCALRC Backup: Location= $BACKUP_DIR!!!"
mkdir -p $BACKUP_DIR
cp *.localrc $BACKUP_DIR

echo "*** LOCALRC Backup: Completed!!!"

