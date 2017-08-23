#!/bin/bash
# Check whether mail delivery works correct

# Send test mails
echo 'This is system test.' | mailx -s testsys $mytestuser

# Delivery check
pathtonewdir=`printf "%s" "$mytestusermaildir" "/new"`
mailname=`grep -r  'This is system test.' "$pathtonewdir" | head -1 | awk -F':' '{print $1}'`
myout=''
counter=0
while [ ! \( "$myout" \) -a \( $counter -lt 10 \) ] 
do
  if [  "$mailname"   ]
  then
    newname=`echo $mailname | sed 's/new/cur/'`
    mv "$mailname" "$newname"
    myout="0"
  else
    sleep 1
    
  fi
## For debug:
#  echo $counter
  counter=$(($counter + 1))
done
if [ "$counter" -eq 10 ]
then
  myout+='TEST-MAIL-CHECK FAILED:'
  myout+=' can not find test mail in  '
  myout+=$pathtonewdir
  myout+='. Probably some parts of your mail system is broken or you might have pointed the wrong mytestusermaildir parameter in config.'
fi
printf "%s\n" "$myout"

