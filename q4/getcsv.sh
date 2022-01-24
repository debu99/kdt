#!/bin/bash

# get all the source data from files into variables
reqPerSec=`cat rps.tsv`
cpuUsage=`cat cpu.tsv`
memoryUsage=`cat memory.tsv`

#echo "$reqPerSec"
#echo "$cpuUsage"
#echo "$memoryUsage"

# since rps data keep the datetime and value while the other two only keep values
# we split each variable to lines, and merge the lines into one line with table separator
# then repace all table character with comma and save as csv file
awk -v awk_lpart="${reqPerSec}" -v awk_mpart="${cpuUsage}" -v awk_rpart="${memoryUsage}" 'BEGIN{split(awk_lpart,lp,/\n/); split(awk_mpart,mp,/\n/); split(awk_rpart,rp,/\n/); for(i=1; i in lp; i++) {printf("%s\t%s\t%s\n",lp[i],mp[i],rp[i])}}' | sed 's/\t/,/g'  > result.csv

