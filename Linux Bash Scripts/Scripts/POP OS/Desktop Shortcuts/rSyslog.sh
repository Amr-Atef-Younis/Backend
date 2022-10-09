#!/bin/bash
systemctl stop syslog.socket rsyslog.service
#sleep 2
#systemctl restart rsyslog
sudo truncate -s 0 /var/log/syslog
