#!/bin/bash

### get user-statistics for all users
list=`sasldblistusers2 | awk -F : '{print $1}'`

for i in $list
do
	bash user-statistics.sh $i "/var/www/html/"
done

