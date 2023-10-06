#!/bin/sh
# ##############################################################################
#
# @description "sample"
# @name sample.sh
# @author T.Hayashi@Rookie Inc
# @version 1.0 2023/10/04
# Copyright(c) 2023 Toshinoli-Hayashi
#
# ##############################################################################
#
# _DEBUG_=1
#
[ ${_DEBUG_} ] && echo "DEBUG MSG: ON" >&2

# Required var
_J2SVDIR=$(dirname $0)
_J2SVLIB="${_J2SVDIR}/lib"


# chk param
if [ -z "${1}" ]; then
  echo >&2 "Error: sample: require conf json file name"
  return 1
fi
if [ -z "${2}" ]; then
  echo >&2 "Error: sample: require tag name"
  return 1
fi
if [ -z "${3}" ]; then
  echo >&2 "Error: sample: require key name"
  return 1
fi
# set var
_jsonfile=${1}
_tag=${2}
_key=${3}

# include lib
_FNCFILE="${_J2SVDIR}/json2shvars.lib.sh"
. ${_FNCFILE}

# make configuration, load and delete
_conf=$(mkConf ${_jsonfile} ${_tag})
. ${_conf}
rm ${_conf}


_var=$(eval "echo \"\${${_key}}\"")
echo "${_tag} var ${_key} ${_var}"



