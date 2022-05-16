#!/usr/bin/env sh

# Account configuration
if [[ -z $DYNHOST_DOMAIN_NAME || -z $DYNHOST_LOGIN || -z $DYNHOST_PASSWORD ]]; then
  echo 'one or more variables are undefined, please set DYNHOST_DOMAIN_NAME, DYNHOST_LOGIN and DYNHOST_PASSWORD'
  exit 1
fi
HOST=${DYNHOST_DOMAIN_NAME}
LOGIN=${DYNHOST_LOGIN}
PASSWORD=${DYNHOST_PASSWORD}

PATH_LOG=/var/log/dynhost.log

echo "[$(date -R)]: Starting dynhost..." >> $PATH_LOG
# Get current IPv4 and corresponding configured
HOST_IP=$(dig +short $HOST A)
CURRENT_IP=$(curl -m 5 -4 ifconfig.co 2>/dev/null)
if [ -z $CURRENT_IP ]
then
  CURRENT_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
fi

# Update dynamic IPv4, if needed
if [ -z $CURRENT_IP ] || [ -z $HOST_IP ]
then
  echo "[$(date -R)]: No IP retrieved" >> $PATH_LOG
else
  if [ "$HOST_IP" != "$CURRENT_IP" ]; then
    RES=$(curl -m 5 -L --location-trusted --user "$LOGIN:$PASSWORD" "https://www.ovh.com/nic/update?system=dyndns&hostname=$HOST&myip=$CURRENT_IP")
    echo "[$(date -R)]: IPv4 has changed - request to OVH DynHost: $RES" >> $PATH_LOG
  else
    echo "[$(date -R)]: IP already up to date, nothing to do here..." >> $PATH_LOG
  fi
fi