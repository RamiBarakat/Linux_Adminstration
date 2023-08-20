#!/bin/bash

startTime=$(date +%s)
echo $startTime

count=0
currentTime=$(date +%s)
while [ $(( ${currentTime} - ${startTime} )) -lt 600 ]; do


        pid=$(ps -ef | grep "/bin/bash ./script.sh"| grep -v grep | awk '{print $2}')
        sleep 2
        currentTime=$(date +%s)
        kill -9 $pid


done
