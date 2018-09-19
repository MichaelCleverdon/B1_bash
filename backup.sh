#!/bin/bash
clear
read -p "Making a backup of the BASH folder, press [enter] to continue"

Time=`date +"%T"`
Day=`date +"%A"`
DayDate=`date +"%d"`
Month=`date +"%B"`
Year=`date +"%Y"`


src=/home/compsci/Desktop/bash
dest=/home/compsci/Desktop/backups

bash_backup () {
if [ -d $dest ]; then
echo -e "\e[38;5;35mBackup folder exists\e[0m"
echo $time
else
echo -e "\e[38;5;35mBackup folder doesn't exist, creating it now ...\e[0m"
mkdir $dest
echo
fi

read -p "Press any key to continue" -n1 -s
mkdir $dest/"$DayDate $Month $Year"
echo

echo -e "\e[38;5;35mBackup started...\e[0m"
tar -czvPf $dest/"$DayDate $Month $Year"/bash_backup.tgz $src

echo
echo -e "\e[38;5;35mHere is the contents of your backup directory\e[0m"
cd $dest
ls -ahl

echo -e "\e[38;5;35mHere is what's inside the backup you just made\e[0m"
cd "$DayDate $Month $Year"
ls -ahl >> /home/compsci/Desktop/BackupLog.txt

read -p "Press [enter] to exit"
cd ~

clear
exit 0
}
non_bash_backup () {
ls -hl
echo "What file directory do you want to back up (Needs to be exact path)"
read src 
echo "Where do you want the backup to go?"
read dest 
echo "What do you want the backup to be called (No .tgz)"
read name 
if [ -d $dest ] && [ -d $dest/"$DayDate $Month $Year" ]; then
echo -e "\e[38;5;35mBackup folder exists\e[0m"
echo $time
else
echo -e "\e[38;5;35mBackup folder doesn't exist, creating it now ...\e[0m"
mkdir $dest
echo
fi

read -p "Press any key to continue" -n1 -s
tar -czvPf $dest/"$DayDate $Month $Year"/$name.tgz $src
cd $dest/"$DayDate $Month $Year"/
ls -ahl >> /home/compsci/Desktop/BackupLog.txt
echo "Your backup is located at $dest/'$DayDate $Month $Year'/$name.tgz"
exit 0
}

echo "Do you want to backup the bash directory? (y/n/exit)"
read answer
case "$answer" in
    yes)
        bash_backup
        ;;
    Yes)
        bash_backup
        ;;
    y)
        bash_backup
        ;;
    Y)
        bash_backup
        ;;
    exit)
        exit 0
        ;;
    Exit)
        exit 0
        ;;
    *)
        non_bash_backup
        ;;
esac

