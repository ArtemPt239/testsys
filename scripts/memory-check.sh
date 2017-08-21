#!/bin/bash
# Ram usage check
# Check if there are at least 20% of memory is free
myout=`sar -r`
if printf "%s" "$myout" | tail -5 | head -4 | awk 'BEGIN {s=0} {s= s + $5} END {if(s/4 > 80) exit 0; else exit 1;}' 
then
  echo "MEMORY-CHECK FAILED:"
  printf "%s\n" "$myout"
else
  echo 0;
fi;
