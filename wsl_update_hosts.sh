#!/bin/sh

HOST_FILE="/mnt/c/Windows/System32/drivers/etc/hosts"
HOST_NAME="ubuntu1804.wsl"
TAG_STR="#FKMS_AC"

ETH0_IP=$(ip a | grep -Ew '^\s*inet.*eth0$' | awk '{print $2}' | cut -d"/" -f1)
echo $ETH0_IP

if grep -q $TAG_STR "$HOST_FILE"; then
  # replace host if any
  TEMP_SED=$(sed -r "s/(.*)^([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}) (.*$TAG_STR)(.*)\r\n/\1$ETH0_IP \3\4/g" $HOST_FILE)
  printf "%s" "$TEMP_SED" > $HOST_FILE
else
  printf "\r\n%s\r\n%s\r\n" "# WSL2 host entry by acamar" "$ETH0_IP $HOST_NAME $TAG_STR" >>  $HOST_FILE
fi
