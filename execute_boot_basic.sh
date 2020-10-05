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
#     ( ( ! command -v failed >/dev/null 2>&1; ) && echo -e "\n \n  ERROR! Loading execute_boot_basic.sh \n \n " && exit 69; )
# } # end execute_as_sudo
# load_execute_boot_basic



 (( DEBUG )) &&  ( typeset -p "THISSCRIPTNAME"  &>/dev/null ) && typeset -gr THISSCRIPTNAME="$(pwd)/$(basename "$0")"
load_execute_as_sudo(){
    # DEBUG=1
    # Test home value part 1
    (( DEBUG )) && echo "USER_HOME:${USER_HOME}  ? 1"
    (( DEBUG )) && echo "-----HOME:${HOME}  ? 1"
    # if ( typeset -p "SUDO_USER"  &>/dev/null ) &&  [ -n "${2+x}" ] ; then
      # exit 0
      # typeset -rg USER_HOME=$(getent passwd "${SUDO_USER}" | cut -d: -f6)
    # else
    if ( ! typeset -p "SUDO_USER"  &>/dev/null ) ; then
      typeset -rg USER_HOME=$HOME
    fi
    (( DEBUG )) && echo "USER_HOME:${USER_HOME}  ? 1"
    (( DEBUG )) && echo "-----HOME:${HOME}  ? 1"
    # DEBUG=0

    # Test home value part 2
    # echo "${USER_HOME}  ? 2"
    # echo "${HOME}  ? 2"
    typeset -r provider="$USER_HOME/_/clis/task_intuivo_cli/execute_as_sudo.sh"
    # Test provider
    # echo "${provider}  ?"
    [   -e "${provider}"  ] && source "${provider}"
    [ ! -e "${provider}"  ] && eval """$(wget --quiet --no-check-certificate  https://raw.githubusercontent.com/zeusintuivo/task_intuivo_cli/master/execute_as_sudo.sh -O -  2>/dev/null )"""   # suppress only wget download messages, but keep wget output for variable
    ( ( ! command -v execute_as_sudo >/dev/null 2>&1; ) && echo -e "\n \n  ERROR! Loading execute_as_sudo \n \n " && exit 69; )
    echo $provider Loaded Now checking..
} # end execute_as_sudo
load_execute_as_sudo

execute_as_sudo

# USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
enforce_variable_with_value HOME $HOME
enforce_variable_with_value SUDO_USER $SUDO_USER
enforce_variable_with_value SUDO_GID $SUDO_GID
enforce_variable_with_value SUDO_COMMAND $SUDO_COMMAND
# declare -rg USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
enforce_variable_with_value USER_HOME $USER_HOME
(( DEBUG )) &&  echo $SUDO_USER
(( DEBUG )) &&  env | grep SUDO
echo " \__________Sudoed Correctly"
echo $provider Loaded 


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
# task_intuivo_cli/execute_as_sudo.sh:execute_as_sudo
task_intuivo_cli/add_error_trap.sh:_trap_on_error
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
        _msg=$(echo "${_execoncli}" > "${_tmp_file}" 2>&1 )
        err=$?
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

(( DEBUG )) && echo $SUDO_USER
(( DEBUG )) && env | grep SUDO
