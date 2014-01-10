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
MYSQL_ADMIN_PASS="openstack"
#MYSQL_ADMIN_PASS="ohhberry3333"

dump_remote_db() {
	NODE=$1
	DATABASE=$2

	_DATE=$(__get_date)
	print_info "DB-DUMP" "Dump $DATABASE"
	dump_remote_database $NODE $DATABASE > sql/$DATABASE-$_DATE.sql
}

dump_remote_db $NODE keystone
dump_remote_db $NODE nova
dump_remote_db $NODE quantum
dump_remote_db $NODE glance
dump_remote_db $NODE cinder
