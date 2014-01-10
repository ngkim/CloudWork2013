#/bin/bash

source "$MNG_ROOT/include/util.sh"
source "$MNG_ROOT/include/print.sh"
source "$MNG_ROOT/include/mysql.sh"

usage() {
 	echo "Usage: $0 [target-node]"
 	echo "   ex) $0 controller" 
}

NODE=$1
if [ -z $NODE ]; then
	usage; exit -1
fi

MODE=BACKUP-MYSQL-$NODE

MYSQL_ADMIN="root"
MYSQL_ADMIN_PASS="ohhberry3333"

DATABASE=quantum

mkdir -p sql
_DATE=$(__get_date)
dump_remote_database $NODE $DATABASE > sql/$DATABASE-$_DATE.sql
