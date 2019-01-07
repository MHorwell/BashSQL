#!/bin/bash

database=sakila
table=versionid

if [ $(mysql -s -u root -h 192.168.56.1 -p123 -e "select count(*) from information_schema.tables where table_schema='$database' and table_name='$table';") -eq 0 ]
then
$(mysql -s -u root -h 192.168.56.1 -p123 -e "create table $database.$table (id int); INSERT INTO $database.$table VALUES (0);")
fi
