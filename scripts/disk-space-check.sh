#!/bin/bash
# check if there are at least 30% of disk-space available in each file system
myout=`df`
if printf "%s" "$myout" | sed '/Filesystem          1K-blocks    Used Available Use% Mounted on/d' | sed 's/%//' | awk 'BEGIN {f = 0;} { if( $5 >= 70) {f = 1;} } END {if(f == 1) exit 0; else exit 1;}' ;   
then
  echo 'DISK-SPACE-CHECK FAILED:';
  printf "%s\n" "$myout";
else 
  echo 0;
fi;




