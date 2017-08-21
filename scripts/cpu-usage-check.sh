#!/bin/bash
# Check whether at least 20% of cpu is idle
hours=`date +%H`
minutes=`date +%M`
if [ \( $hours = '00' \) -a \( $minutes -lt 15 \) ]
then
  echo 10;
else
  myout=`LC_TIME=en_UK.utf8 sar -u | tail -5 | head -4 `
  if [ `printf "%s\n" "$myout" | awk '{s+=$8;} END {printf("%f\n",s/4);}'` \< 20 ]; then 
    echo 'CPU-USAGE-CHECK FAILURE:';
    printf "%s\n" "$myout";
  else
    echo 0;
  fi
fi

