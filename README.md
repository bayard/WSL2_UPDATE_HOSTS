## Update wsl2 hosts file with current ip of ubuntu VM.
1. Set **C:/Windows/System32/drivers/etc/hosts permission**  
Set permission of ```C:/Windows/System32/drivers/etc/hosts```, grant all permission to current login user, 
and set file as writable. Use ```"vi /mnt/c/Windows/System32/drivers/etc/hosts"``` to verify the file is writtable in ubuntu.

2. In ubuntu, create script to use in systemctl service for update ip address in hosts file:  
see script: wsl_update_hosts.sh  
```
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
  echo "\n#WSL2 host entry by acamar\n$ETH0_IP $HOST_NAME $TAG_STR" >>  $HOST_FILE
fi
```

3. In ubuntu, create a new systemctl service to update ip after network change:  
- ```Put update_wsl_hosts.service in: /etc/systemd/system/update_wsl_hosts.service```
- ```sudo systemctl enable update_wsl_hosts.service```
- ```sudo systemctl start update_wsl_hosts.service```

**Make sure step 1 done correctly, scripts can be adjusted regard to different linux distributions(Ubuntu/Fedora/...).**

```
Working well in:
Windows 11 version 22H2/Ubuntu 18.04
11/30/2022
```
