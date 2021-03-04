#!/bin/bash

set -o pipefail

set +e

# Script trace mode
if [ "${DEBUG_MODE}" == "true" ]; then
    set -o xtrace
fi

CONFIG_FILE="/etc/unimus-core/unimus-core.properties"

# default value of unimus server port
[ -z "$UNIMUS_SERVER_ADDRESS" ] && { UNIMUS_SERVER_ADDRESS=127.0.0.1; }
[ -z "$UNIMUS_SERVER_PORT" ] && { UNIMUS_SERVER_PORT=5509; }
[ -z "$UNIMUS_SERVER_ACCESS_KEY" ] && { UNIMUS_SERVER_ACCESS_KEY="NOT_A_VALID_ACCESS_KEY"; }

[ -z "$TZ" ] && { TZ="UTC"; }
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


[ ! -f $CONFIG_FILE ] && { touch $CONFIG_FILE; }

[ $( grep -i "unimus.address=" $CONFIG_FILE | wc -l ) -eq 0 ] && { echo "unimus.address=" >> $CONFIG_FILE; }
[ ! -z $UNIMUS_SERVER_ADDRESS ] && { echo "Updating unimus.address in config ..."; sed -i s@unimus.address=.*@unimus.address=$UNIMUS_SERVER_ADDRESS@g $CONFIG_FILE; }

[ $( grep -i "unimus.port=" $CONFIG_FILE | wc -l ) -eq 0 ] && { echo "unimus.port=" >> $CONFIG_FILE; } 
[ ! -z $UNIMUS_SERVER_PORT ] && { echo "Updating unimus port in config..."; sed -i s@unimus.port=.*@unimus.port=$UNIMUS_SERVER_PORT@g $CONFIG_FILE; }

# remove multiple config lines
sed '/unimus.access.key/d' $CONFIG_FILE
#[ ! -z $UNIMUS_SERVER_ACCESS_KEY ] && { echo "Updating access key in config..."; sed -i s@unimus.access.key=.*@unimus.access.key=$UNIMUS_SERVER_ACCESS_KEY@g $CONFIG_FILE; }
echo "unimus.access.key=$UNIMUS_SERVER_ACCESS_KEY" >> $CONFIG_FILE

exec "$@"