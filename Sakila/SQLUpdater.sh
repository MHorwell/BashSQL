#!/bin/bash

/home/matthew/Documents/Sakila/tableChecker.sh
versionNumber=$(mysql -s -u root -h 192.168.56.1 -p123 -e "SELECT * from sakila.versionid;")

#sorting sql files
fileNames=$(find /home/matthew/Documents/Sakila/[0-9]*.sql| cut -d/ -f6 | sort -n)

echo $fileNames
for i in $fileNames
do
	fileVersion=$(echo $i | sed -E 's/[^0-9]*//g')
	if [ $fileVersion -gt $versionNumber ] 
	then
		echo $i
		fileContents=$(cat /home/matthew/Documents/Sakila/$i)
		mysql -s -u root -h 192.168.56.1 -p123 -e "USE sakila; $fileContents"
		returnCode=$?
		time=$(date)

		if [ $returnCode -ne 0 ]
		then 
			echo "$time $i FAIL" >> logfile.txt
		break

		else
			echo "$time $i SUCCESS" >> logfile.txt
			versionNumber=$fileVersion
		break
		fi
	fi
done
echo $fileToExecute
$(mysql -s -u root -h 192.168.56.1 -p123 -e "UPDATE sakila.versionid set id = $versionNumber;")
