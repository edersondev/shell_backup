#!/bin/bash

if [ ! $1 ] ; then
	echo "Enter the soket"
	exit
fi

if [ ! $2 ]; then
	echo "Enter db user"
	exit
fi

if [ ! $3 ]; then
	echo "Enter password db user"
	exit
fi

if [ ! $4 ]; then
	echo "Enter databases to backup"
	exit
fi

if [ ! $5 ]; then
	echo "Enter path to save sql file"
	exit
fi

datefile=`date +%Y%m%d-%H%M`

socket=$1
userdb=$2
password=$3
databases=$4
path_to_backup=$5

# Delete old files with modification time older than 5 days before backup
find $path_to_backup -type f -mtime +5 -name '*.sql' -execdir rm -- {} \;

IFS=',' read -r -a arrdb <<< "$databases"
for database in "${arrdb[@]}"
do
	`mysqldump -S $socket -u $userdb -p$password --set-gtid-purged=OFF $database > $path_to_backup$datefile-$database.sql`
done

