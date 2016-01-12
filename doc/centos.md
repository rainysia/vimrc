Centos Config
===========

#CentOS 7

###Ulimit -n
----------
cat /proc/sys/fs/file-max  will affect the limits
vim /etc/security/limits.conf, for centos7
add the below content at the end of file then restart server
```
* soft nofile 102400
* hard nofile 102400
```

###Network initial start when reboot
----------
cat /etc/sysconfig/network-scripts/ifcfg-enp2s0
```
ONBOOT="yes"
```
