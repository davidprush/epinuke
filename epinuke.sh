#!/bin/bash
# epinuke.sh
# Date: 15 June 2019
# License:
# MIT License

# Copyright (c) 2019 David P. Rush

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
# Usage: epinuke.sh [action(s)] [option(s)] [path...]
# All actions and options must be separated by spaces
# 	INVALID: epinuke.sh -get -hp [path...]
# 	USE: epinuke.sh get -h -p [path...]
# The action performs the option, using either the system and/or backup file created with get.
# Order of action precedence: get, install, list, compare
# Order of option precedence is the order passed to the script through arguements.
# Multiple actions and options can be used, the script will follow above precedence.

# DEFAULTS
# 	default action is help
# 	default option is -a
# 	default path is the current directory

# ACTIONS
# 	all-actions 		perform all actions against option(s)
# 	compare 			compare [option(s)] against current system
# 						*requires valid back files to compare against current system
# 	get 				get selected [option(s)] files in path
# 	install 			install selected [option(s)] from files in path
# 						*this verifies files in path
# 	list 				list [option(s)] data in formatted output
# 						*requires valid backup files
# 	help 				display help for [option] or all options 

# OPTIONS
# 	-a					perform [action] against [option(s)]
# 	-h					perform [action(s)] only against users home directory
# 	-k 					perform [action(s)] only against apt-keys (apt repos)
# 	-p					perform [action(s)] only against apt packages
# 	-r					perform [action(s)] only against apt repos								
# 						(epinuke --help or epinuke [option] -h)

# EXAMPLES
#     Run all actions against all all-actions & all options script (sudo used as required per command):
#         $ sh epinuke all-actions -a
#         *this uses the scripts directory and creates a temp and backup directory
#     Install the list of all options from backup (requires [path...]):
#         $ sh epinuke install -a '/media/user/backup/'
#     Get all options from system and save as backup in [path...]:
#     	$ sh epinuke get -a '/media/data/user/backup'
#     List all keys and save in backup, if no path is provided, 
#     	a temp dir will be created and deleted when the script exits
#     	$ sh epinuke list -k '~/backup'			

# GLOBAL VARIABLES

# Web link to source
SOURCE="https://github.com/davidprush/epinuke.git" 

# Valid file
DIR_VALID=False
BACKUP_PATH="$(PWD)/backup"

# Color for text output
NOCLR="\\033[0m"
GREEN="\\033[1;32m"
RED="\\033[1;31m"
YELLOW="\\033[1;33m"
PURPLE="\\033[1;35m"

# Warning messages
OPT_ERR="The following option is invalid:."
NO_ROOT="Do not run as root!"
DETAIL_ROOT="epinuke uses sudo when required and you will enter your password as needed." 
NO_PATH="Backup path required!"
DETAIL_PATH="epinuke requires backup path for all procedures, this is where information files are saved."
NO_DIR="The following directory does not exist: "
# FUNCTIONS

check_root() {
if [ $(id -u) = 0 ]; then
	warn_user "\\n$NO_ROOT" "$RED"
	warn_user "$DETAIL_ROOT" "$YELLOW"
   exit 1
fi
}

warn_user(){
if [ $# -gt 0 ] 
then
echo -e "${$1}$2${NOCLR}"
fi
}

run_get(){

}

run_install(){

}

run_list(){

}

run_compare(){

}

run_all_actions(){
 run_get
 run_install
 run_list
 run_compare
}





get_opts(){
while getopts ":a:g:i:l:c:" opt 
do
	case "${opt}" in
	a ) 
	ALL_OPTS=${OPTARG}
	;; 
	g ) 
	GET_OPTS=${OPTARG}
	;; 
	i ) 
	INS_OPTS=${OPTARG}
	;; 
	l ) 
	LST_OPTS=${OPTARG}
	;; 
	c ) 
	CMP_OPTS=${OPTARG}
	;;
	esac 
done
shift $(OPTIND -1))
}

# RUN MAIN SCRIPT

check_root
get_args
run_log
clean_up