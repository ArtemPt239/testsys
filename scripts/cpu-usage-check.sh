#!/bin/bash
# Check whether at least 20% of cpu is idle
hours=`date +%H`
minutes=`date +%M`
# Since sar is not working correctly a few minutes after midnight we would assume that everything is ok without checking it
if [ \( $hours = '00' \) -a \( $minutes -lt 19 \) ]
then
  echo 0;
else
  myout=`LC_TIME=en_UK.utf8 sar -u | tail -5 | head -4 `
  if [ `printf "%s\n" "$myout" | awk '{s+=$8;} END {printf("%f\n",s/4);}'` \< 20 ]; then 
    echo 'CPU-USAGE-CHECK FAILURE:';
    printf "%s\n" "$myout";
  else
    echo 0;
  fi
fi

