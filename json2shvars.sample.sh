#!/bin/sh
# ##############################################################################
#
# @description "sample"
# @name json2shvars.sample.sh
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
  echo >&2 "Error: json2shvars: require conf json file name"
  return 1
fi
if [ -z "${2}" ]; then
  echo >&2 "Error: json2shvars: require 1st key name"
  return 1
fi
# set var
_jsonfile=${1}
_key=${2}

# include lib
_FNCFILE="${_J2SVDIR}/json2shvars.lib..sh"
. ${_FNCFILE}

# make configuration, load and delete
_conf=$(mkConf ${_jsonfile} ${_key})
. ${_conf}
rm ${_conf}

echo "var _TOKEN ${_TOKEN}"



