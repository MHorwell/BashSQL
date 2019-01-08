#!/bin/bash

database=testDatabase
#Not blank
if [ $(mysql -u root -h 192.168.56.1 --skip-column-names -p123 -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$database';") -eq 0 ]
	then
	$(mysql -s -u root -h 192.168.56.1 -p123 -e "CREATE DATABASE $database; CREATE TABLE $database.versionid; INSERT INTO $database.versionid VALUES (0);")
elif [ $(mysql -s -u root -h 192.168.56.1 -p123 -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$database' AND table_name='versionid';") -eq 0 ]
then
$(mysql -s -u root -h 192.168.56.1 -p123 -e "CREATE TABLE $database.versionid (id int); INSERT INTO $database.versionid VALUES (0);")
fi
