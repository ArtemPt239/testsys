#!/bin/bash

### per-user mailusage statistic

_user=$1
if [ $_user ]
then

### specify path to roundcube dir here:
_path=$2
_path_userlogins=`printf "%s/logs/userlogins" $_path`
_path_sendmail=`printf "%s/logs/sendmail" $_path`

echo $_user

echo --------------------------

echo "Last login    :" `cat $_path_userlogins | grep $_user | grep "Successful login for" | tail -1 |  awk '{ print($1 " " $2 " " $3) }' `

echo "Total logins  :" `cat $_path_userlogins |  grep $_user | grep "Successful login for"  | sed 's/.*Successful login for //' | awk '{ print($1) }' | wc -l`

echo "failed logins :" `cat $_path_userlogins | grep $_user | grep "Failed login for"  | sed 's/.*Failed login for //' | awk '{ print($1) }' | wc -l`

echo "recieved mails:" `cat /var/log/maillog* | grep "to=<"$_user">"  | grep "postfix/smtp" | wc -l `

sent_counter=$((`cat /var/log/maillog* | grep "from=<"$_user">"  | wc -l ` / 2))

echo "sent mails    :" $sent_counter

echo "sent mails(since the beginnig of the world):" `cat $_path_sendmail | grep "User "$_user | wc -l`

echo "successful logins per ip:"
cat $_path_userlogins | grep $_user | grep "Successful login for"  | sed 's/.*Successful login for //' | awk '{ print($1 " " $5) }' | uniq -c | sort -nr

echo "failed logins per ip:"
cat $_path_userlogins | grep $_user | grep "Failed login for"  | sed 's/.*Failed login for //' | awk '{ print($1 " " $3) }' | uniq -c | sort -nr

echo --------------------------
echo "(recieved and sent mails calculated since last logrotation)"
else
echo "Need to specify username"
fi

