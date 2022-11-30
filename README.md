## Update wsl2 hosts file with current ip of ubuntu VM.
1. Set C:/Windows/System32/drivers/etc/hosts permission
Set permission of ```C:/Windows/System32/drivers/etc/hosts```, grant all permission to current login user, 
and set file as writable. Use ```"vi /mnt/c/Windows/System32/drivers/etc/hosts"``` to verify the file is writtable in ubuntu.

2. In ubuntu, create script to use in systemctl service for update ip address in hosts file  
```see script: wsl_update_hosts.sh```

3. In ubuntu, create a new systemctl service to update ip after network change
- ```Put update_wsl_hosts.service in: /etc/systemd/system/update_wsl_hosts.service```
- ```sudo systemctl enable update_wsl_hosts.service```
- ```sudo systemctl start update_wsl_hosts.service```

**Make sure step 1 done correctly, scripts can be adjusted regard to different linux distributions(Ubuntu/Fedora/...).**

```
Works great in:
Windows 11/Ubuntu 18.04
11/30/2022
```
