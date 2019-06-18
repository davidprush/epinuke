# epinuke!

> The ultimate pre- & post- installation script...aka for frequent nukers!

**[For future ramblings from me about creating this script, please checkout my github.io page](https://davidprush.com)**

## Previous Failures

### My initial embarrasing Fedora scripts...

* [fedora-post-install](https://github.com/davidprush/fedora-post-install)
* [FedoraPostInstall](https://github.com/davidprush/FedoraPostInstall)

### Another wonderful bash script...making progress!

* [ubuntu-post-install](https://github.com/davidprush/ubuntu-post-install)


## Usage: 
```shell
epinuke.sh [action(s)] [option(s)] [path...]
```
All actions and options must be separated by spaces
* INVALID: 
```shell
    epinuke.sh -get -hp [path...]
```
* USE:
```shell 
    epinuke.sh get -h -p [path...]
```

## Notes:
* The action performs the option, using either the system and/or backup file created with get action.
*Order of action precedence: get, install, list, compare
*Order of option precedence is the order passed to the script through arguements.

## DEFAULTS
* default action is help
* default option is -a
* default path is the current directory

## ACTIONS
* all-actions       perform all actions against option(s)
* compare           compare [option(s)] against current system
                    *requires valid back files to compare against current system
* get               get selected [option(s)] files in path
* install           install selected [option(s)] from files in path
                    *this verifies files in path
* list              list [option(s)] data in formatted output
                    *requires valid backup files
* help              display help for [option] or all options 

## OPTIONS
* -a                    perform [action] against [option(s)]
* -h                    perform [action(s)] only against users home directory
* -k                    perform [action(s)] only against apt-keys (apt repos)
* -p                    perform [action(s)] only against apt packages
* -r                    perform [action(s)] only against apt repos                              
                    (epinuke --help or epinuke [option] -h)

## EXAMPLES
* Run all actions against all all-actions & all options script (sudo used as required per command):   
```shell
    sh epinuke all-actions -a
```
...this uses the scripts directory and creates a temp and backup directory
* Install the list of all options from backup (requires [path...]):
    
```shell
    $ sh epinuke install -a '/media/user/backup/'
```
* Get all options from system and save as backup in [path...]:
```shell
    $ sh epinuke get -a '/media/data/user/backup'
```
* List all keys and save in backup, if no path is provided, 
    * a temp dir will be created and deleted when the script exits
```shell
    sh epinuke list -k '~/backup'
```         
