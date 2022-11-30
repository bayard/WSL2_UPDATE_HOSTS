Update wsl2 hosts file with current ip of ubuntu VM.

>1. Set C:/Windows/System32/drivers/etc/hosts permission
>Set permission of C:/Windows/System32/drivers/etc/hosts, grant all permission to current login user, and set file as writable.
>Use "vi /mnt/c/Windows/System32/drivers/etc/hosts" to verify the file is writtable in ubuntu.
>
>2. In ubuntu, create update/add host entry script to use in systemctl service
>script: wsl_update_hosts.sh
>
>3. In ubuntu, create a new systemctl service to update ip after network change
>service file: update_wsl_hosts.service
>
>put the file in: /etc/systemd/system/update_wsl_hosts.service
>sudo systemctl enable update_wsl_hosts.service
>sudo systemctl start update_wsl_hosts.service
>
>Works great in:
>Windows 11/Ubuntu 18.04
>11/30/2022
