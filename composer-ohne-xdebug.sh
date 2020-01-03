#!/bin/bash 
# 
# @author Zeus Intuivo <zeus@intuivo.com>
#
#
#

# Prepare Messengers
                  function _say_error_and_exit_worker() {
                    echo -e "\\033[1;31m"
                    echo  "$@" "!!!"
                    echo -e "\\033[0m "
                    exit 69;
                  }
                          function !!!() {
                            _say_error_and_exit_worker "${@}"
                          }
                  function _anounce_worker() {
                    echo -e "\\033[38;5;93m"
                    echo "${@}"
                    echo -e "\\033[0m "
                  }
                          function -() {
                            _anounce_worker ${@}
                          }
# Init
                  function check_php() {
                    if command -v php >/dev/null 2>&1; then #Command Exists
                      {
                        - "PHP ..ok"
                      }
                    else
                      {
                        !!! PHP Does not exist
                      }
                    fi
                  }
check_php

                  function check_composer_json_existance() {
                    if [ ! -f "$PWD/composer.json" ] ; then  # file not exists
                        {
                          !!! There is no composer.json File
                        }
                    fi
                  }
check_composer_json_existance

XDEBUG_FOLDER=""
OPTIONS=""
COMPOSER_EXECUTABLE_FULL_PATH=$(which composer)

                  function check_xdebug_or_exit() {
                      if [ -z "$XDEBUG_FOLDER"  ] ;  then   # if parameter value is empty
                        {
                          !!! Error could not find any ! ... xdebug.so
                        }
                      fi
                  }
                  function find_xdebug() {
                    - Finding ... first xdebug.so
                      # use --exit for NetBSD
                      # XDEBUG_FOLDER=$(dirname $(find / -name "xdebug.so" -print -exit  | head -1) )  #  or use  export VAR=/home/me/mydir/file.c  && ${VAR%/*}
                      set -eu
                      set -o pipefail
                    XDEBUG_FOLDER=$(dirname  $(find / -name "xdebug.so" -print -quit  | head -1) )   #  or use  export VAR=/home/me/mydir/file.c  && ${VAR%/*}
                    - $XDEBUG_FOLDER
                    check_xdebug_or_exit
                  }
find_xdebug

                  function get_options() {
                    # Faster ? exclude mysql wddx and pg
                    OPTIONS=$(ls -1 "${XDEBUG_FOLDER}" |  grep -v xdebug |   grep --invert-match opcache|   egrep --invert-match 'mysql|wddx|pgsql' |  sed --expression 's/\(.*\)/ --define extension=\1/'|   tr --delete '\n' )
                    # Only xdebug  excluded ?
                    #OPTIONS=$(ls -1 "${XDEBUG_FOLDER}" |  grep -v xdebug |   grep --invert-match opcache |  sed --expression 's/\(.*\)/ --define extension=\1/'|   tr --delete '\n' )
                  }
get_options
                  function composer_install() {
                      - "php --no-php-ini " ${OPTIONS} ${COMPOSER_EXECUTABLE_FULL_PATH}  "$1"
                      php --no-php-ini ${OPTIONS} ${COMPOSER_EXECUTABLE_FULL_PATH} "$1"
                  }
composer_install "install"


