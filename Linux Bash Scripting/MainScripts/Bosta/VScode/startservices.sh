#!/bin/bash
echo "${PASSWORD}" | sudo -S mongod --fork --logpath /var/lib/mongodb/mongodb.log --dbpath /var/lib/mongod
echo "${PASSWORD}" | sudo -S systemctl start mysql.service &
echo "${PASSWORD}" | sudo -S /usr/bin/redis-server &
sleep 1
echo ''
