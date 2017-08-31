#!/bin/bash
# Total system check. use scripts from dir scripts which end with "-check.sh".
# Path to testsys sir
pathToDir='/usr/local/testsys'

# Set up different variables
source /usr/local/testsys/config

totalout=''
for script in `printf "%s" "$pathToDir" '/scripts/'*'-check.sh'` 
do
  temp=`bash $script 2>&1`
  if [ "$temp" !=  "0" ] 
  then
    totalout=`printf "%s\n%s\n"  "$totalout" "$temp"` 
  fi
done



# Print to stdout for cron daemon
# Use this if you use crond aability to send mails for notification
# printf "%s" "$totalout"

# Send test results to administrator
if [ -n "$totalout" ] 
then
  printf "%s" "$totalout" | mailx -s "MONITORING SYSTEM ALERT" "$myadminmail"
fi;

# Write results to log file
printf "%s system check finished %s\n" "`date`" "$totalout"  >> `printf "%s" "$pathToDir" "/log"`

