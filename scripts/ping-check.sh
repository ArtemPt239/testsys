#!/bin/bash
# Check whether at leadt 3 of 4 packages sent to 8.8.8.8 were received
myout=`ping -c4 8.8.8.8`
if [[ `echo $myout  | grep received | sed 's/.*\([0-9] received\).*/\1/g' |  awk '{print $1}'` -ge 3 ]] ; then
echo 0;
else
echo 'PING-CHECK FAILED:';
printf "%s\n" "$myout";
fi;



