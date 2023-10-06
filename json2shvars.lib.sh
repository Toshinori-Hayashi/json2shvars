#!/bin/sh
# ##############################################################################
# Usage   : mkConf <conf json file> <1st key name>
# Require : ${_J2SVLIB}
# Return  : conf temp file
# make conf data to specified conf file name
mkConf(){(
  :
# ##############################################################################
  # chk param
  if [ -z "${1}" ]; then
    echo >&2 "Error: mkConf: require conf json file name"
    return 1
  fi
  if [ -z "${2}" ]; then
    echo >&2 "Error: mkConf: require 1st key name"
    return 1
  fi

  # set var
  __jsonfile=${1}
  __key=${2}
  __conftmp=$(mktemp ./CONFTMP.XXXXXXXX)

  # clear conf
  echo "" > ${__conftmp}
  /bin/sh                                                                       \
    ${_J2SVLIB}/parsrj.sh ${__jsonfile}                                          |
    grep "$.${__key}"                                                           |
    sed "s/$\..*\.\([a-zA-Z0-9_-]*\[*[0-9]*\]*\) \(.*\)/\1=\"\2\"/"             |
    grep -v "\[.*\]"                                                            |
    while read -r __ll
    do
      echo "${__ll}" >> ${__conftmp}
    done

  [ ${_DEBUG_} ] && __dbg=$(cat ${__conftmp})
  [ ${_DEBUG_} ] && echo "mkConf Intermediate file contents: ${__dbg}" >&2

  /bin/sh                                                                       \
    ${_J2SVLIB}/parsrj.sh ${__jsonfile}                                          |
    grep "$.${__key}"                                                           |
    sed "s/$\..*\.\(.*\) \(.*\)/\1/"                                            |
    grep "\[.*\]"                                                               |
    sed "s/\[.*\]//"                                                            |
    uniq                                                                        |
    while read -r __ll
    do
      echo "${__ll}=\" "  >> ${__conftmp}
      /bin/sh                                                                   \
        ${_J2SVLIB}/parsrj.sh ${__jsonfile}                                      |
        grep "$.${__key}"                                                       |
        sed "s/$\..*\.\(.*\) \(.*\)/\1=\"\2\"/"                                 |
        grep "${__ll}"                                                          |
        sed "s/${__ll}.*=\"\(.*\)\"/\1/"                                        |
        while read -r __ll2
        do
          echo " ${__ll2} " >> ${__conftmp}
        done
      echo " \" "  >> ${__conftmp}
    done

  [ ${_DEBUG_} ] && __dbg=$(cat ${__conftmp})
  [ ${_DEBUG_} ] && echo "mkConf Result file: ${__dbg}" >&2

  echo ${__conftmp}

)}







# ##############################################################################
#   TESTING SECTION
# ##############################################################################

_MYNAME=$(basename $0|tr '[:lower:]' '[:upper:]')

if [ ${_MYNAME} = "FUNCTIONS.SH" ]; then
  :
  _DEBUG_=1
  _J2SVDIR=$(dirname $0)
  _J2SVLIB="${_J2SVDIR}/lib"

  [ ${_DEBUG_} ] && echo "START TEST ${_MYNAME}" >&2

  mkConf sample.json production
  # [ ${_DEBUG_} ] && echo "var _TOKEN ${_TOKEN}" >&2
  # [ ${_DEBUG_} ] && echo "var _INTERFACE= ${_INTERFACE=}" >&2

fi