# Linux terminal shell script to do backup
Simple shell script to compress folders to backup

The script create files *.tar.gz and delete old files with modification time older than 5 days before backup.

Exemple:
./script_backup.sh /var/www path1,path2 /home/user/backups
