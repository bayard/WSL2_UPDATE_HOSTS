#!/bin/sh

HOST_FILE="/mnt/c/Windows/System32/drivers/etc/hosts"
HOST_NAME="ubuntu1804.wsl"
TAG_STR="#FKMS_AC"

ETH0_IP=$(ifconfig eth0 | grep -w inet | awk '{print $2}')
echo $ETH0_IP

if grep -q $TAG_STR "$HOST_FILE"; then
  #replace host if any
  TEMP_SED=$(sed -r "s/(.*)^([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}) (.*$TAG_STR)(.*)/\1$ETH0_IP \3\4/g" $HOST_FILE)
  echo "$TEMP_SED" > $HOST_FILE
else
  echo "\n#WSL2 host entry by acamar\n $ETH0_IP $HOST_NAME $TAG_STR" >>  $HOST_FILE
fi
