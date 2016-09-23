#!/bin/bash

if [ ! $1 ] ; then
	echo "Enter the path to backup"
	exit
fi

if [ ! $2 ]; then
	echo "Enter the paths to compress separated by ',' or enter 'all' to compress all folders"
	exit
fi

if [ ! $3 ]; then
	echo "Enter the path to save compress file."
	exit
fi

base_path=$1
paths=$2
path_to_backup=$3

# Delete old files with modification time older than 5 days before backup
find $path_to_backup -type f -mtime +5 -name '*.gz' -execdir rm -- {} \;

datefile=`date +%Y%m%d-%H%M`

if [ "$paths" == "all" ];then
	# set path for loop
	path_origin="$base_path/*"
	
	# Do backup
	for files in $path_origin
	do
		fname=`basename $files`
		archive_file="$datefile-$fname.tar.gz"
		echo "Create file: $archive_file"
		tar -C $base_path -zcf $path_to_backup$archive_file $fname
	done
	
	exit
else
	IFS=',' read -r -a arrpath <<< "$paths"
	for element in "${arrpath[@]}"
	do
		archive_file="$datefile-$element.tar.gz"
		echo "Create file: $archive_file"
		tar -C $base_path -zcf $path_to_backup$archive_file $element
	done
fi

exit

