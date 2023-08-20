#!/bin/bash


who | cut -d ' ' -f 1,10,11 > ec.txt
dash=" - "
rm final.txt


while read -r line; do

        string=$( echo $line | cut -d ' ' -f 2,3 )
        name=$(echo $line | cut -d ' ' -f 1)
        string+=$dash
        string+=$name
        echo "$string" >> final.txt

done < ec.txt
