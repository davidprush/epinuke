#!/bin/bash

# Web link to source
SOURCE="https://github.com/davidprush/epinuke.git" 

# Valid file
DIRVALID=False
BAKPATH="$(pwd)/backup"

# Color for text output
NOCLR="\\033[0m"
GREEN="\\033[1;32m"
RED="\\033[1;31m"
YELLOW="\\033[1;33m"
PURPLE="\\033[1;35m"

# Warning messages
OPTERR="The following option is invalid:."
NOROOT="Do not run as root!"
DETAILROOT="epinuke uses sudo when required and you will enter your password as needed." 
NOPATH="Backup path required!"
DETAILPATH="epinuke requires backup path for all procedures, this is where information files are saved."
NODIR="The following directory does not exist: "
UNKERR="Unknown error...closing!"
NOPATHARG="Missing path for output files!"

# FUNCTIONS

warn_user(){
if [ -n "$1" ] && [ -n "$2" ]; then
	echo "${2}$1${NOCLR}"
else
	echo "${NOCLR}$UNKERR"
fi
}

check_root(){
if [ $(id -u) = 0 ]; then
	warn_user "$NOROOT" "$RED"
	warn_user "$DETAILROOT" "$YELLOW"
	exit 1
fi
}

request_path(){
echo "The current default path is: \\n\\n \\t\\t\\t ${$pwd}" 
read -p "" ""NEWPATH
}

# enter_dir(){
# if [ DIRVALID==False ]
# then
# 	read -p "Enter new path to backup directory: " NEWPATH
# 	mkdir $NEWPATH
# 	check_bak_path $NEWPATH
# fi
# }

# # Create and validate directory
# create_dir(){
# makedir $1
# if [ -d "$1" ]
# then
# 	DIRVALID=True
# 	BAKPATH=$1
# else 
# 	DIRVALID=False
# 	enter_dir
# fi
# }
# 
run_help(){
cat << _EOF_
Usage: epinuke.sh [action(s)] [option(s)] [path...]
All actions and options must be separated by spaces
	INVALID: epinuke.sh -get -hp [path...]
	USE: epinuke.sh get -h -p [path...]
The action performs the option, using either the system and/or backup file created with get.
Order of action precedence: get, install, list, compare
Order of option precedence is the order passed to the script through arguements.
Multiple actions and options can be used, the script will follow above precedence.

DEFAULTS
	default action is help
	default option is -a
	default path is the current directory

ACTIONS
	all-actions 		perform all actions against option(s)
	compare 			compare [option(s)] against current system
						*requires valid back files to compare against current system
	get 				get selected [option(s)] files in path
	install 			install selected [option(s)] from files in path
						*this verifies files in path
	list 				list [option(s)] data in formatted output
						*requires valid backup files
	help 				display help for [option] or all options 

OPTIONS
	-a					perform [action] against [option(s)]
	-h					perform [action(s)] only against users home directory
	-k 					perform [action(s)] only against apt-keys (apt repos)
	-p					perform [action(s)] only against apt packages
	-r					perform [action(s)] only against apt repos								
						(epinuke --help or epinuke [option] -h)

EXAMPLES
    Run all actions against all all-actions & all options script (sudo used as required per command):
        $ sh epinuke all-actions -a
        *this uses the scripts directory and creates a temp and backup directory
    Install the list of all options from backup (requires [path...]):
        $ sh epinuke install -a '/media/user/backup/'
    Get all options from system and save as backup in [path...]:
    	$ sh epinuke get -a '/media/data/user/backup'
    List all keys and save in backup, if no path is provided, 
    	a temp dir will be created and deleted when the script exits
    	$ sh epinuke list -k '~/backup'

AUTHOR
    David Rush

LICENSE
	MIT

SOURCE
    $LINK

_EOF_
}

# Verify $1 is a valid directory
check_bak_path(){
if [ -n "$@" ]; then
	local PARSPATH="$(echo "$@" | grep ' ' | tr '\r ' '\n' | grep "/")"
	if [ -d "$PARSPATH" ]; then
		DIRVALID=True
	else
		DIRVALID=False
		warn_user "$NODIR$1" "YELLOW"
		create_dir "$1"
	fi
else
	warn_user "$NOPATHARG" "RED"
	request_path
fi
}

get_args(){
if [ "$#" -gt 0 ]; then
check_bak_path "$1"
	if [ $DIRVALID && True ]; then
		shift
	else
	    case "$1" in
			all-actions)
				get_opts
				run_all_actions
				shift
				;;
			get)
				get_opts
				run_get
				shift
				;;
			install)
				get_opts
				run_install
				shift
				;;
			list)
				get_opts
				run_list
				shift
				;;
			compare)
				get_opts
				run_compare
				shift
				;;
			help)
				run_help
				shift
				;;
			\? )
				warn_user "$OPTERR$OPTARG" "YELLOW"
				exit 1
				;;
			: )
				
				shift
				;; 
	    esac
	fi
fi
}

check_root
check_bak_path "$@"
get_args "$@"
