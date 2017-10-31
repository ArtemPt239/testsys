#!/bin/bash

### calculate amount of succses and failed logins

echo "Here comes general statistics"
cat /var/www/roundcubemail/logs/userlogins  | grep "Successful login for" | sed 's/.*Successful login for //' | awk '{ print($1) }' | uniq -c | sort -nr
echo "Here comes amount-login-ip atatistics"
cat /var/www/roundcubemail/logs/userlogins  | grep "Successful login for" | sed 's/.*Successful login for //' | awk '{ print($1 " " $5) }' | uniq -c | sort -nr


