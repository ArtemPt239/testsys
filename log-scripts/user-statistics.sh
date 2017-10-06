#!/bin/bash

### per-user mailusage statistic

_user=$1
if [ $_user ]
then
echo $_user

echo --------------------------

echo "Last login    :" `cat /var/www/roundcubemail/logs/userlogins | grep $_user | grep "Successful login for" | tail -1 |  awk '{ print($1 " " $2 " " $3) }' `

echo "Total logins  :" `cat /var/www/roundcubemail/logs/userlogins | grep $_user | grep "Successful login for"  | sed 's/.*Successful login for //' | awk '{ print($1) }' | wc -l`

echo "failed logins :" `cat /var/www/roundcubemail/logs/userlogins | grep $_user | grep "Failed login for"  | sed 's/.*Failed login for //' | awk '{ print($1) }' | wc -l`

echo "recieved mails:" `cat /var/log/maillog | grep "to=<"$_user">"  | grep "postfix/smtp" | wc -l `

echo "sent mails    :" `cat /var/www/roundcubemail/logs/sendmail | grep "User "$_user | wc -l`

echo "successful logins per ip:"
cat /var/www/roundcubemail/logs/userlogins | grep $_user | grep "Successful login for"  | sed 's/.*Successful login for //' | awk '{ print($1 " " $5) }' | uniq -c | sort -nr

echo "failed logins per ip:"
cat /var/www/roundcubemail/logs/userlogins | grep $_user | grep "Failed login for"  | sed 's/.*Failed login for //' | awk '{ print($1 " " $3) }' | uniq -c | sort -nr

echo --------------------------
echo "(recieved mails calculated since last logrotation)"
else
echo "Need to specify username"
fi

