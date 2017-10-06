#!/bin/bash

### get user-statistics for all users
list=`cat /etc/dovecot/users | awk -F : '{print $1}'`

for i in $list
do
	bash user-statistics.sh $i
done

