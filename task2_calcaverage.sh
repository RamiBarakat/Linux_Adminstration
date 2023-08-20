#!/bin/bash
cd /tmp/task2

cpuTmp=$(find . -name 'cpu*')
cpuFile=$( echo $cpuTmp | cut -d '/' -f 2)

memTmp=$(find . -name 'memory*')
memFile=$( echo $memTmp | cut -d '/' -f 2)

diskTmp=$(find . -name 'disk*')
diskFile=$( echo $diskTmp | cut -d '/' -f 2)



#echo $diskFile
#echo $memFile
#echo $cpuFile

cnt=0
usedn=0
availablen=0
while read -r line;
do
	
	if [ $cnt -eq 1  ]
	then

	#echo $line
	used=$( echo $line | cut -d ' ' -f 3)
	#echo "This is used $used"
	usedn=$(( $usedn + $used  ))
	#echo $usedn
	available=$( echo $line | cut -d ' ' -f 2)
	availablen=$(( $availablen + $available ))
	#echo $avaliable
	#echo $used

	fi
	cnt=1

done < ${diskFile}

diskLines=0
diskLines=$( cat $diskFile | wc -l )
diskLines=$(( diskLines - 1  ))

avaAvgDisk=$(($availablen / $diskLines))
usedAvgDisk=$(($usedn / $diskLines))

timestamp=$(echo $diskFile | cut -d '_' -f 2 | cut -d '.' -f 1)
echo $timestamp

##echo $avaAvgDisk
##echo $usedAvgDisk
file="$(find . -name "disk_*")"
cat << EOF > var/www/html/web/disk.html
    <html>
    <head>
        <title>
        DISK UTLIZATION STATISTICS
        </title>
    </head>

    <body>

         <h1>Memory Statistics</h1>
         <pre>$(cat $file)</pre>
         <p>Average Occupied Disk Space = $usedAvgDisk MB </p>
         <p>Average Free Disk Space = $avaAvgDisk MB</p>
	 <p>Happened at ($timestamp)</p>
    </body>
    </html>
EOF


##################################cpu##################################################


cnt=0
usedCpu=0
while read -r line;
do
	if [ $cnt -eq 1 ]
	then
		cpUtil=$( echo $line | cut -d ' ' -f 2)
		#echo $cpUtil
		#:usedCpu=$(  echo "$usedCpu + $cpUtil" |   bc)
		#total=$(echo "scale=2; ${usedCpu} + ${cpUtil}" | bc)
		#total=$(awk "BEGIN { print $usedCpu + $cpUtil }")
		usedCpu=$(awk -v usedCpu="$usedCpu" -v cpUtil="$cpUtil" 'BEGIN { print usedCpu + cpUtil }')
		#total=$(python -c "print(${usedCpu} + ${cpUtil})")
		#echo $usedCpu
	



	fi
	cnt=1

done < ${cpuFile}

cpuLines=0
cpuLines=$(cat $cpuFile | wc -l)
cpuLines=$((cpuLines - 1))
#echo $cpuLines
#avgCpuUtil=$(($usedCpu / $cpuLines))
avgCpuUtil=$(awk -v usedCpu="$usedCpu" -v cpuLines="$cpuLines" 'BEGIN { print usedCpu / cpuLines }')
##echo $avgCpuUtil
file="$(find . -name "cpu_*")"

cat << EOF > var/www/html/web/cpu.html
    <html>
    <head>
        <title>
        CPU UTLIZATION STATISTICS
        </title>
    </head>

    <body>
   	
	 <h1>$title</h1>
	 <pre>$(cat $file)</pre> 
	 <p>the total CPU utilization = $avgCpuUtil </p>
   	 <p>Happened at ($timestamp)</p>
    </body>
    </html>
EOF

##########################MEM###########################################


cnt=0
totalMemAdd=0
totalFreeMem=0
totalUsedMem=0
while read -r line;
do
        if [ $cnt -eq 1 ]
        then
		totalMem=$(echo $line | awk '{ print $2 }' )
		totalMemAdd=$(( $totalMem + $totalMemAdd ))
		#echo $totalMem
		#echo $totalMemAdd
		
		usedMem=$( echo $line | awk '{print $3}' )
		totalUsedMem=$(( $usedMem + $totalUsedMem ))
		#echo $FreeMem

		freeMem=$( echo $line | awk '{print $4}' )
		totalFreeMem=$(( $freeMem + $totalFreeMem ))
	
		#echo $totalUsedMem	
 
        fi
        cnt=1

done < ${memFile}

echo "$totalMemAdd"
echo "$freeMem"
echo "$totalUsedMem"

avgUsedUtil=$(awk -v totalUsedMem="$totalUsedMem" -v totalMemAdd="$totalMemAdd" 'BEGIN { print totalUsedMem / totalMemAdd * 100 }')
avgFreeUtil=$(awk -v totalFreeMem="$totalFreeMem" -v totalMemAdd="$totalMemAdd" 'BEGIN { print totalFreeMem / totalMemAdd * 100}')

echo $avgUsedUtil
echo $avgFreeUtil



file="$(find . -name "memory_*")"
cat << EOF > var/www/html/web/memory.html
    <html>
    <head>
        <title>
        MEM UTLIZATION STATISTICS
        </title>
    </head>

    <body>

         <h1>Memory Statistics</h1>
         <pre>$(cat $file)</pre>
         <p>Occupied Memory Utilization % = $avgUsedUtil% </p>
	 <p>Free Memory Utilization % = $avgFreeUtil%</p>
	 <p>Happened at ($timestamp)</p>
    </body>
    </html>
EOF
