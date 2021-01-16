#!/usr/bin/env bash
#
# @author Zeus Intuivo <zeus@intuivo.com>
#
#
# How to use: start

# Include this at the beginning of the script
# export THISSCRIPTCOMPLETEPATH
# typeset -r THISSCRIPTCOMPLETEPATH="$(pwd)/$(basename "$0")"  # § This goes in the FATHER-MOTHER script
# typeset -i _err=0
# load_execute_boot_basic_with_sudo(){
#     # shellcheck disable=SC2030
#     if ( typeset -p "SUDO_USER"  &>/dev/null ) ; then
#     {
#       # export USER_HOME
#       # typeset -r USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)  # Get the caller's of sudo home dir Just Linux
#       # shellcheck disable=SC2046
#       # shellcheck disable=SC2031
#       export USER_HOME
#       typeset -r USER_HOME="$(echo -n $(bash -c "cd ~${SUDO_USER} && pwd"))"  # Get the caller's of sudo home dir LINUX and MAC
#     }
#     else
#     {
#       local USER_HOME=$HOME
#     }
#     fi
#     local -r provider="$USER_HOME/_/clis/execute_command_intuivo_cli/execute_boot_basic.sh"
#     echo source "${provider}"
#     # shellcheck disable=SC1090
#     [   -e "${provider}"  ] && source "${provider}"
#     [ ! -e "${provider}"  ] && eval """$(wget --quiet --no-check-certificate  https://raw.githubusercontent.com/zeusintuivo/execute_command_intuivo_cli/master/execute_boot_basic.sh -O -  2>/dev/null )"""   # suppress only wget download messages, but keep wget output for variable
#     if ( command -v failed >/dev/null 2>&1; ) ; then
#     {
#       return 0
#     }
#     else
#     {
#       echo -e "\n \n  ERROR! Loading execute_boot_basic.sh \n \n "
#       exit 1;
#     }
#     fi
#     return 0
# } # end load_execute_boot_basic_with_sudo

# load_execute_boot_basic_with_sudo
# _err=$?
# if [ $_err -ne 0 ] ;  then
# {
#   >&2 echo -e "ERROR There was an error loading load_execute_boot_basic_with_sudo Err:$_err "
#   exit $_err
# }
# fi


# function check_system_requirements(){
#   # This function check_system_requirements is sample of what to do next to keep testing
#   # or executing like checking for requirements

#   verify_is_installed git
#   verify_is_installed awk
#   verify_is_installed date
#   # verify_is_installed nvm
#   verify_is_installed node
#   verify_is_installed npm
#   local -i _err=0
#   local _node_version=''
#   _node_version=$(node --version 2>&1 | cüt "v")  # stout and stderr both get
#   _err=$?
#   (( DEBUG )) && echo "_node_version: $_node_version --- _err: $_err"
#   if [ $_err -ne 0 ] ;  then
#   {
#     >&2 echo -e "ERROR There was an reading version of node  Err:$_err Output: $_node_version"
#     exit $_err
#   }
#   fi
#   enforce_variable_with_value _node_version  $_node_version
#   file_exists .nvmrc
#   # ...
#   # ... etc ... etc .. check check ... do do ...
#   # ...
#   return 0 # remember to always return 0 to good, 1 or not/0 for fail
# } # end check_system_requirements
# check_system_requirements

# How to use: // end


typeset -i _err=0
CYAN="\033[01;36m"
BRIGHT_BLUE87="\033[38;5;87m"
echo -e "${CYAN}"
if (( DEBUG )) &&  ( typeset -p "THISSCRIPTCOMPLETEPATH"  &>/dev/null ) ; then
{
  export THISSCRIPTCOMPLETEPATH
  typeset -r THISSCRIPTCOMPLETEPATH="$(pwd)/$(basename "$0")"
}
fi

load_execute_as_sudo(){
    # DEBUG=1
    # Test home value part 1
    (( DEBUG )) && echo "USER_HOME:${USER_HOME}  ? 1"
    (( DEBUG )) && echo "-----HOME:${HOME}  ? 1"
    # if ( typeset -p "SUDO_USER"  &>/dev/null ) &&  [ -n "${2+x}" ] ; then
      # exit 0
      # export USER_HOME
      # typeset -r USER_HOME=$(getent passwd "${SUDO_USER}" | cut -d: -f6)
    # else
    # shellcheck disable=SC2030
    if ( ! typeset -p "SUDO_USER"  &>/dev/null ) ; then
      export USER_HOME
      typeset -r USER_HOME=$HOME
    fi
    (( DEBUG )) && echo "USER_HOME:${USER_HOME}  ? 1"
    (( DEBUG )) && echo "-----HOME:${HOME}  ? 1"
    # DEBUG=0

    # Test home value part 2
    # echo "${USER_HOME}  ? 2"
    # echo "${HOME}  ? 2"
    typeset provider="$USER_HOME/_/clis/task_intuivo_cli/execute_as_sudo.sh"
    # Test provider
    # wget --quiet --no-check-certificate  https://raw.githubusercontent.com/zeusintuivo/task_intuivo_cli/master/execute_as_sudo.sh -O -
    # curl https://raw.githubusercontent.com/zeusintuivo/task_intuivo_cli/master/execute_as_sudo.sh  -o -
    # echo "${provider}  ?"
    # shellcheck disable=SC1090
    if [   -e "${provider}"  ] ; then
    {
      source "${provider}"
    }
    else
    {
      provider="https://raw.githubusercontent.com/zeusintuivo/task_intuivo_cli/master/execute_as_sudo.sh"
      if ( command -v wget >/dev/null 2>&1; ) ; then
        echo "   wget --quiet --no-check-certificate "${provider}" -O -"
        eval """$(wget --quiet --no-check-certificate "${provider}" -O -  2>/dev/null )"""   # suppress only wget download mess$
      elif ( command -v curl >/dev/null 2>&1; ); then
        echo "   curl "${provider}" -o -"
        eval """$(curl "${provider}" -o -  2>/dev/null )"""   # suppress only curl download messages, but keep curl output for $
      else
        echo -e "\n \n  ERROR! Could not download execute_boot_basic.sh. There is no wget or curl installed or reacheable \n \n "
        exit 1;
      fi
    }
    fi
    if ( command -v execute_as_sudo >/dev/null 2>&1; ) ; then
    {
      echo "$provider" Loaded Now checking..
      return 0
    }
    else
    {
      echo -e "\n \n  ERROR! Loading execute_as_sudo.sh \n \n "
      exit 1;
    }
    fi
    echo "$provider" Loaded Now checking..
    return 0
} # end execute_as_sudo
load_execute_as_sudo

execute_as_sudo
_err=$?
if [ $_err -ne 0 ] ;  then
{
  >&2 echo -e "ERROR There was an error loading load_execute_as_sudo  execute_as_sudo Err:$_err "
  exit $_err
}
fi

# USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
enforce_variable_with_value HOME "$HOME"
# shellcheck disable=SC2031
enforce_variable_with_value SUDO_USER "$SUDO_USER"
enforce_variable_with_value SUDO_GID "$SUDO_GID"
enforce_variable_with_value SUDO_COMMAND "$SUDO_COMMAND"
# declare -rg USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
enforce_variable_with_value USER_HOME "$USER_HOME"
# shellcheck disable=SC2031
(( DEBUG )) &&  echo "$SUDO_USER"
(( DEBUG )) &&  env | grep SUDO
echo -e "${CYAN} \__________Sudoed Correctly ${BRIGHT_BLUE87}✔️${CYAN}"
# shellcheck disable=SC2031
echo -e "${CYAN}                           ${LIGHTPINK} SUDO_USER ️${YELLOW_OVER_DARKBLUE} $SUDO_USER ${BRIGHT_BLUE87}✔️${CYAN}"
echo -e "${CYAN}                           ${LIGHTPINK} USER_HOME ️${YELLOW_OVER_DARKBLUE} $USER_HOME ${BRIGHT_BLUE87} ✔️${CYAN}"
echo -e "${provider} Loaded ${BRIGHT_BLUE87}✔️${CYAN}"


# exit 0
# . ./execute_as_sudo.sh
# THISSCRIPTCOMPLETEPATH="$(pwd)/$THISSCRIPTCOMPLETEPATH"
# export THISSCRIPTCOMPLETEPATH=`basename "$0"`
# DEBUG=1
 (( DEBUG )) && echo "THISSCRIPTCOMPLETEPATH:: $THISSCRIPTCOMPLETEPATH"
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
    # - Announce "${@}"
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
    local -r _scripts=$(grep -v "^#" <<<"
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
      (( DEBUG )) && echo _function_test:: "$_function_test"
      (( DEBUG )) && echo "----------_url:: $_url"

      # Second part distributed values downloads
      if [[ "${_provider}" == *"https://"*  ]] ; then
      {
        (( DEBUG )) && echo "is https://"
        if ( command -v wget >/dev/null 2>&1; ) ; then
        {
          echo -e "try:    wget --quiet --no-check-certificate "${_url}" -O -"
          _execoncli="""$(wget --quiet --no-check-certificate  "${_url}" -O -  2>/dev/null )"""   # suppress only wget download messages, but keep wget output for variable
          err=$?
        }
        elif ( command -v curl >/dev/null 2>&1; ); then
        {
          echo -e "try:    curl "${_url}" -o -"
          _execoncli="""$(curl "${_url}" -o - 2>/dev/null )"""   # suppress only curl download messages, but keep curl output for variable
          err=$?
        }
        else
        {
          echo -e "\n \n  ERROR! Could not download ${_script}. There is no wget or curl installed or reacheable \n \n "
          exit 1;
        }
        fi
        # _msg=$("${_execoncli}")
        # err=$?
        # if [ $err -ne 0 ] ;  then
        # {
        #  echo -e "\nERROR downloading ${_script}\n_url: ${_url}  \n_msg: ${_msg} \n_execoncli: ${_execoncli}  \n_err: ${_err} \n\n"
        #  exit 1
        # }
        # fi
        _msg=$(echo -n "${_execoncli}" > "${_tmp_file}" 2>&1 )
        err=$?
        if [ $err -ne 0 ] ;  then
        {
          echo -e "\nERROR trying to write \n_tmpfile=${_tmp_file} \n_script: ${_one} \n_msg: ${_msg} \n_err: ${_err}  \n\n"
          exit 1
        }
        fi
        #  ++ sources
        [[ ! -e "${_tmp_file}" ]]  && echo -e "\nERROR Local tmp File does not exists or cannot be accessed: \n${_tmp_file}" && exit 1
        # shellcheck disable=SC1090
        . "${_tmp_file}"
        err=$?
        if [ $err -ne 0 ] ;  then
        {
          # shellcheck disable=SC1090
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
        # shellcheck disable=SC1090
        . "${_url}"
        # . /USER_HOME/zeus/_/clis/task_intuivo_cli/add_error_trap.sh
        err=$?
        # (( DEBUG )) && echo "---- source err: $_err"
        if [ $err -ne 0 ] ;  then
        {
          # shellcheck disable=SC1090
          _msg=$(. "${_url}" 2>&1 )
          echo -e "\nERROR sourcing from file \n_url=${_url} \n_script: ${_one} \n_msg: ${_msg} \n_err: ${_err}  \n\n"
          exit 1
        }
        fi
      }
      fi
      # Test function exitance if loaded propertly
      # type -f on_error
      # (( DEBUG )) &&  echo "-------command:: $(command -v on_error )"
      #  ( ( ! command -v passed >/dev/null 2>&1; ) && echo -e "\n \n  ERROR! Loading struct_testing \n \n " && exit 69; )
      if ( ( ! command -v "${_function_test}" >/dev/null 2>&1; ) && exit 69; ) ;  then
      {
        # cat "${_tmp_file}"
        echo -e "\n \n  ERROR! Loading < ${_script} > \n\n Could not find function test < $_function_test > \n \n " && exit 1;
      }
      else
      {
        echo -e "${_url} Loaded Correctly ${BRIGHT_BLUE87}✔️${CYAN}"
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
    return 0
} # end function boostrap_intuivo_bash_app
boostrap_intuivo_bash_app

# shellcheck disable=SC2031
(( DEBUG )) && echo "$SUDO_USER" || true
(( DEBUG )) && env | grep SUDO || true
