#!/bin/bash
### display statistics of users logins, recieved and sent mail

source ../config
cd userstat
if [ "$mysystemtype" == cyrus ]
then
  bash all-cyrus-statistics.sh 
fi

if [ "$mysystemtype" == dovecot ]
then
  bash all-dovecot-statistics.sh
fi


