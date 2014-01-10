#/bin/bash

source "$MNG_ROOT/include/util.sh"

usage() {
 	echo "Usage: $0 [node-to-backup]"
 	echo "   ex) $0 controller" 
}

NODE=$1
if [ -z $NODE ]; then
	usage; exit -1
fi

_LOG_DIR="iptables"

_DATE=$(__get_date)

_LOG_NAME="$NODE-$_DATE.log"
_LOG="$_LOG_DIR/$_LOG_NAME"

_LOG_LINK="$NODE-iptables.log"

mkdir -p $_LOG_DIR

rm -rf $_LOG
rm -rf $_LOG_DIR/$_LOG_LINK

echo "****************************************" >> $_LOG
echo " iptables rules" >> $_LOG
echo "****************************************" >> $_LOG
ssh $NODE "iptables -L" >> $_LOG
echo "" >> $_LOG
echo "" >> $_LOG
echo "****************************************" >> $_LOG
echo " iptables NAT rules" >> $_LOG
echo "****************************************" >> $_LOG
ssh $NODE "iptables -L -t nat" >> $_LOG

ln -s $_LOG_NAME $_LOG_DIR/$_LOG_LINK
