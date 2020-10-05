#!/usr/bin/env bash
#
# @author Zeus Intuivo <zeus@intuivo.com>
#
#
# How to use:

# Include this at the beginning of the script

# typeset -gr THISSCRIPTNAME="$(pwd)/$(basename "$0")"
# load_execute_boot_basic(){
#     # Test home value part 1
#     # echo "${USER_HOME}  ? 1"
#     # echo "${HOME}  ? 1"

#     if ( typeset -p "SUDO_USER"  &>/dev/null ) ; then
#       typeset -rg USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
#     else
#       local USER_HOME=$HOME
#     fi
#     # Test home value part 2
#     # echo "${USER_HOME}  ? 2"
#     # echo "${HOME}  ? 2"
#     local provider="$USER_HOME/_/clis/execute_command_intuivo_cli/execute_boot_basic.sh"
#     # Test provider
#     # echo "${provider}  ?"
#     [   -e "${provider}"  ] && source "${provider}"
#     [ ! -e "${provider}"  ] && eval """$(wget --quiet --no-check-certificate  https://raw.githubusercontent.com/zeusintuivo/execute_command_intuivo_cli/master/execute_boot_basic.sh -O -  2>/dev/null )"""   # suppress only wget download messages, but keep wget output for variable
#     ( ( ! command -v execute_as_sudo >/dev/null 2>&1; ) && echo -e "\n \n  ERROR! Loading execute_boot_basic.sh \n \n " && exit 69; )
# } # end execute_as_sudo
# load_execute_boot_basic



 (( DEBUG )) &&  ( typeset -p "THISSCRIPTNAME"  &>/dev/null ) && typeset -gr THISSCRIPTNAME="$(pwd)/$(basename "$0")"
load_execute_as_sudo(){
    # Test home value part 1
    # echo "${USER_HOME}  ? 1"
    # echo "${HOME}  ? 1"

    if ( typeset -p "SUDO_USER"  &>/dev/null ) ; then
      typeset -rg USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
    else
      local USER_HOME=$HOME
    fi
    # Test home value part 2
    # echo "${USER_HOME}  ? 2"
    # echo "${HOME}  ? 2"
    local provider="$USER_HOME/_/clis/task_intuivo_cli/execute_as_sudo.sh"
    # Test provider
    # echo "${provider}  ?"
    [   -e "${provider}"  ] && source "${provider}"
    [ ! -e "${provider}"  ] && eval """$(wget --quiet --no-check-certificate  https://raw.githubusercontent.com/zeusintuivo/task_intuivo_cli/master/execute_as_sudo.sh -O -  2>/dev/null )"""   # suppress only wget download messages, but keep wget output for variable
    ( ( ! command -v execute_as_sudo >/dev/null 2>&1; ) && echo -e "\n \n  ERROR! Loading execute_as_sudo \n \n " && exit 69; )
} # end execute_as_sudo
load_execute_as_sudo

execute_as_sudo

# USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
ensure_is_defined_and_not_empty HOME
ensure_is_defined_and_not_empty SUDO_USER
ensure_is_defined_and_not_empty SUDO_GID
ensure_is_defined_and_not_empty SUDO_COMMAND
# declare -rg USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
ensure_is_defined_and_not_empty USER_HOME
(( DEBUG )) &&  echo $SUDO_USER
(( DEBUG )) &&  env | grep SUDO

# exit 0
# . ./execute_as_sudo.sh
# THISSCRIPTNAME="$(pwd)/$THISSCRIPTNAME"
# export THISSCRIPTNAME=`basename "$0"`
# DEBUG=1
 (( DEBUG )) && echo "THISSCRIPTNAME:: $THISSCRIPTNAME"
function on_int() {
    echo -e " ☠ ${LIGHTPINK} KILL EXECUTION SIGNAL SEND ${RESET}"
    echo -e " ☠ ${YELLOW_OVER_DARKBLUE}  ${*} ${RESET}"
    exit 69;
}
trap on_int INT
boostrap_intuivo_bash_app(){
    # : Execute "${@}"
    #
    # !!! ¡ ☠ Say error "${@}" and exit
    #
    # - Anounce "${@}"
    # · • Say "${@}"
    # “ Comment "${@}"
    #
    local -i _err
    local _msg
    local _url=""
    local _execoncli=""
    (( DEBUG )) && echo "----------HOME:: $USER_HOME"
    local -r _filelocal="${USER_HOME}/_/clis"
    local _project=""
    local -r _fileremote="https://raw.githubusercontent.com/zeusintuivo"
    [[ -d "${_filelocal}" ]] &&  local -r _provider="${_filelocal}"
    [[ ! -d "${_filelocal}" ]] &&  local -r _provider="${_fileremote}"
    local _one=""
    local _script=""
    local _tmp_file=""
    local _function_test=""
    # Project  /  script / test function test if loaded should exist
    local -ra _scripts=$(grep -v "^#" <<<"
# task_intuivo_cli/execute_as_sudo.sh:sudo_check
task_intuivo_cli/add_error_trap.sh:on_error
execute_command_intuivo_cli/execute_command:_execute_command_worker
execute_command_intuivo_cli/struct_testing:passed
" )
    (( DEBUG )) && echo "------_scripts:: $_scripts"
    while read -r _one; do
    {
      [[ -z "${_one}" ]] && continue                         # if  empt loop again
      # ( declare -p "${_one}"  &>/dev/null )  && continue     # if not  empty and defined
      (( DEBUG )) && echo "----------_one:: $_one"
      (( DEBUG )) && echo "-----_provider:: $_provider"

      # First part read _one and distribute values
      if [[ "${_one}" == *"/"*  ]] ; then
      {
        _project=$(echo "${_one}" | cut -d\/ -f1  2>&1)
        _script=$(echo "${_one}" | cut -d\/ -f2  2>&1 )
        if [[ "${_script}" == *:*  ]] ; then
        {
          _function_test=$(echo "${_script}" | cut -d\: -f2  2>&1 )
          _script=$(echo "${_script}" | cut -d\: -f1  2>&1)
        }
        fi
        (( DEBUG )) && echo "------_project:: $_project"
        (( DEBUG )) && echo "-------_script:: $_script"
        if [[ "${_provider}" == *"https://"*  ]] ; then
        {
          _url="${_provider}/${_project}/master/${_script}"
        } else {
          _url="${_provider}/${_project}/${_script}"
        }
        fi
      } else {
        if [[ "${_one}" == *:*  ]] ; then
        {
          _function_test=$(echo "${_one}" | cut -d: -f2  2>&1 )
          _one=$(echo "${_one}" | cut -d: -f1  2>&1)
        }
        fi
        _url="${_provider}/${_one}"
      }
      fi
      _tmp_file="/tmp/${_script}"
      (( DEBUG )) && echo "-----_tmp_file:: $_tmp_file"
      (( DEBUG )) && echo _function_test:: $_function_test
      (( DEBUG )) && echo "----------_url:: $_url"

      # Second part distributed values downloads
      if [[ "${_provider}" == *"https://"*  ]] ; then
      {
        (( DEBUG )) && echo "is https://"
        _execoncli=$(wget --quiet --no-check-certificate  ${_url} -O -  2>/dev/null )   # suppress only c_url download messages, but keep c_url output for variable
        err=$?
        if [ $err -ne 0 ] ;  then
        {
          echo -e "tried: _execoncli=\$(wget --quiet --no-check-certificate  ${_url} -O -  2>&1 )"
          echo -e "\nERROR downloading ${_script}\n_url: ${_url} \n_execoncli: ${_execoncli}  \n_err: ${_err} \n\n"
          exit 1
        }
        fi
        # Eval
        # +  just evals
        # _msg=$(eval """${_execoncli}""" 2>&1 )
        # err=$?
        # if [ $err -ne 0 ] ;  then
        # {
        #   _msg=$(eval """${_execoncli}""" 2>&1 )
        #   echo -e "\nERROR with ${_one}\n_url: ${_url} \neval: ${_execoncli} \nresult: \n${_msg} \n\n"
        #   exit 1
        # }
        # fi

        # Source
        #  + writes to tmp and sources
        #  ++ writes to tmp
        _msg=$(echo "${_execoncli}" > "${_tmp_file}" 2>&1 )
        err=$?
        # (( DEBUG )) && echo "---- write tmp err: $_err"
        if [ $err -ne 0 ] ;  then
        {
          echo -e "\nERROR trying to write \n_tmpfile=${_tmp_file} \n_script: ${_one} \n_msg: ${_msg} \n_err: ${_err}  \n\n"
          exit 1
        }
        fi
        #  ++ sources
        [[ ! -e "${_tmp_file}" ]]  && echo -e "\nERROR Local tmp File does not exists or cannot be accessed: \n${_tmp_file}" && exit 1
        . "${_tmp_file}"
        err=$?
        if [ $err -ne 0 ] ;  then
        {
          _msg=$(. "${_tmp_file}" 2>&1 )
          echo -e "\nERROR sourcing from file \n_tmpfile=${_tmp_file} \n_script: ${_one} \n_msg: ${_msg} \n_err: ${_err}  \n\n"
          exit 1
        }
        fi
      }
      else
      {
        (( DEBUG )) && echo "-----is a file:: $_url "
        [[ ! -e "$_url" ]]  && echo -e "\nERROR Local File does not exists  or cannot be accessed: \n ${_url}" && exit 1
        (( DEBUG )) && echo "----file exits:: $_url"
        . "${_url}"
        # . /USER_HOME/zeus/_/clis/task_intuivo_cli/add_error_trap.sh
        err=$?
        # (( DEBUG )) && echo "---- source err: $_err"
        if [ $err -ne 0 ] ;  then
        {
          _msg=$(. "${_url}" 2>&1 )
          echo -e "\nERROR sourcing from file \n_url=${_url} \n_script: ${_one} \n_msg: ${_msg} \n_err: ${_err}  \n\n"
          exit 1
        }
        fi
      }
      fi
      # Test function exitance if loaded propertly
      # type -f on_error
      (( DEBUG )) &&  echo "-------command:: $(command -v on_error )"
      #  ( ( ! command -v passed >/dev/null 2>&1; ) && echo -e "\n \n  ERROR! Loading struct_testing \n \n " && exit 69; )
      if ( ( ! command -v "${_function_test}" >/dev/null 2>&1; ) && exit 69; ) ;  then
      {
        # cat "${_tmp_file}"
        echo -e "\n \n  ERROR! Loading < ${_script} > \n\n Could not find function test < $_function_test > \n \n " && exit 1;
      }
      else
      {
        echo $_url Loaded Correclty
      }
      fi
    }
    done <<< "${_scripts}"
    unset _err
    unset _msg
    unset _url
    unset _execoncli
    unset _one
    unset _script
    unset _project
    unset _tmp_file
    unset _function_test
    # unset _scripts # unset: _scripts: cannot unset: readonly variable ..is normal behavoir or bash as of now
    # unset _provider  # unset: _scripts: cannot unset: readonly variable ..is normal behavoir or bash as of now
} # end function boostrap_intuivo_bash_app
boostrap_intuivo_bash_app

# echo hei
# function sudo_check(){
#   typeset -gr AMISUDO=$(sudo -n uptime 2>&1|grep "load"|wc -l)
#   if [ ${AMISUDO} -gt 0 ]; then
#     echo -e "\033[01;7m * * * Executing as sudo * * * \033[0m"
#     return 0
#   else
#     echo "Needs to run as sudo ... ${0}"
#     execute_as_sudo
#     return 0
#   fi
# }
# DEBUG=1
  # set -xE -o functrace   # Strict and Report Errors
# function ensure_is_defined_and_not_empty(){
#     # Sample use
#     #  ( declare -p "USER_HOME"  &>/dev/null )    @ Is USER_HOME declared and not empty?
#     #  [ -n "${USER_HOME+x}" ] && echo "USER_HOME 1"   @ Is USER_HOME declared and not empty?
#     #  ensure_is_defined_and_not_empty USER_HOME  && echo "USER_HOME ensure_is_defined_and_not_empty 1"
#     ( declare -p "${1}"  &>/dev/null ) ||  ( echo ""${1}" ensure_is_defined_and_not_empty failed " ; exit 1 ; return 1);
#   }
# sudo_check
# declare -rg USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
# ensure_is_defined_and_not_empty HOME

# ensure_is_defined_and_not_empty SUDO_USER
(( DEBUG )) && echo $SUDO_USER
(( DEBUG )) && env | grep SUDO
# declare -rg USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
# ensure_is_defined_and_not_empty USER_HOME


# ensure_is_defined_and_not_empty HOME  || echo "HOME ensure_is_defined_and_not_empty 1" && exit 1
# ensure_is_defined_and_not_empty USER_HOME  || echo "USER_HOME ensure_is_defined_and_not_empty 1"  && exit 1
# ensure_is_defined_and_not_empty SUDO_USER  || echo "SUDO_USER ensure_is_defined_and_not_empty 1"  && exit 1

# exit 0

# exit 0



# function kill(){
#   echo -e "\033[01;7m*** $THISSCRIPTNAME Exit ...\033[0m"
#   ls -lad /opt/sublime_text/Packages/Package\ Control.sublime-package
#   tree /opt/sublime_text/Packages/Package\ Control.sublime-package
#   ls -lad /home/zeus/.config/sublime-text-3/Installed\ Packages/Package\ Control.sublime-package
#   tree /home/zeus/.config/sublime-text-3/Installed\ Packages/Package\ Control.sublime-package
# }
# #trap kill ERR
# trap kill EXIT
# #trap kill INT

# passed Home identified:$USER_HOME
# passed Caller user identified:$SUDO_USER
# file_exists_with_spaces $USER_HOME
