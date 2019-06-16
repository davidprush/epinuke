#!/bin/bash
# epinuke init bash script
# 
LINE_BREAK="\n"

# delete old temp directory
if [ -d "temp" ] 
then
	echo "Deleting old temp directory..."
	rm -rf temp
fi

# create temp directory
mkdir temp

# change to temp dir
echo "Changing direcory to temp"
cd temp
echo $LINE_BREAK

# get system packages currently installed
echo "Getting packages from dpkg and creating file pkgs..."
dpkg --get-selections > pkgs
echo $LINE_BREAK

# get user installed packages in human readable format
# and store the output in en.packages.h
echo "Getting apt history log and creating file user_installed_pkgs..."
HISTORY_LOG='/var/log/apt/history.log'
echo $(grep 'Commandline: apt install' $HISTORY_LOG) \
| sed -e 's/\<Commandline: apt install\>//g' \
| tr '\r ' '\n' \
| grep -v '^$' > user_installed_pkgs
echo $LINE_BREAK

# copy current system sources
echo "Enter your password for the following command:"
echo "         sudo apt cp -R /etc/apt/sources.list*"
sudo cp -R /etc/apt/sources.list* .
echo $LINE_BREAK

# export all keys to file
#echo "Getting apt keys and creating apt_keys file..."
#echo $(sudo apt-key exportall) > apt_keys
#echo $LINE_BREAK

# get current system info
echo "Getting sysinfo and creating sysinfo file..."
uname -a | tr '\r ' '\n' > sysinfo
echo $LINE_BREAK

# get current home directory file structure
echo "Getting home directory structure and storing it in home.tree"
tree -R ~/ > home_tree
echo $LINE_BREAK

echo "Initialization complete!"
exit 0