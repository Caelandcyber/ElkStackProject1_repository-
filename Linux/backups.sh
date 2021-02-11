#! /bin/bash
sudo mkdir -p /var/backupsudo tar cvf /var/backup/home.tar homesudo mv /var/backup/home.tar /var/backup/home.0102020.tarsudo tar cvf /var/backup/system.tar /homesudo ls -lh /var/backup > /var/backup/filereport.txtsudo free -h /var/backup/disk_report.txt
