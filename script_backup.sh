#!/bin/bash

# set path for loop
path_origin="/var/www/*"

# set path for tar
change_dir="/var/www"

# path to backup
path_backup="/var/backups/"

datefile=`date +%Y%m%d-%H%M`

# Delete old files with modification time older than 5 days before backup
find $path_backup -type f -mtime +5 -name '*.gz' -execdir rm -- {} \;

# Do backup
for files in $path_origin
do
	fname=`basename $files`
	archive_file="$datefile-$fname.tar.gz"
	echo "Create file: $archive_file"
	tar -C $change_dir -zcf $path_backup$archive_file $fname
done

exit 0
