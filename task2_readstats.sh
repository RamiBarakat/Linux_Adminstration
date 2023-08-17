#!/bin/bash



timestamp=$(date "+%T")



find . -name "memory*" -exec rm -f {} \;
touch "memory_${timestamp}.txt"
free -m> "memory_${timestamp}.txt"



find . -name "disk*" -exec rm -f {} \;
touch "disk_${timestamp}.txt"
df > "disk_${timestamp}.txt"



find . -name "cpu*" -exec rm -f {} \;
touch "cpu_${timestamp}.txt"
ps -ao pid,%cpu > "cpu_${timestamp}.txt"

