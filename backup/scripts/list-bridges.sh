#/bin/bash

source "$MNG_ROOT/include/util.sh"

usage() {
 	echo "Usage: $0 [target-node]"
 	echo "   ex) $0 controller" 
}

NODE=$1
if [ -z $NODE ]; then
	usage; exit -1
fi

_LOG_DIR="bridges"

_DATE=$(__get_date)
_LOG_NAME="$NODE-$_DATE.log"

_LOG_FILE="$_LOG_DIR/$_LOG_NAME"
_LOG_LINK="$NODE-bridges.log"

mkdir -p $_LOG_DIR

rm -rf $_LOG_FILE
rm -rf $_LOG_DIR/$_LOG_LINK
echo "****************************************" >> $_LOG_FILE
echo " Linux Bridges" >> $_LOG_FILE
echo "****************************************" >> $_LOG_FILE
ssh $NODE "brctl show" >> $_LOG_FILE
echo "" >> $_LOG_FILE
echo "" >> $_LOG_FILE
echo "****************************************" >> $_LOG_FILE
echo " Open vSwitch" >> $_LOG_FILE
echo "****************************************" >> $_LOG_FILE
ssh $NODE "ovs-vsctl show" >> $_LOG_FILE

ln -s $_LOG_NAME $_LOG_DIR/$_LOG_LINK
