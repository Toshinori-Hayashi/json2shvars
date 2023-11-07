![GitHub](https://img.shields.io/github/license/Toshinori-Hayashi/json2shvars)

![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/Toshinori-Hayashi/json2shvars)

# json2shvars
Library of Register json to Shellscript variables

## requirement Lib

- [@ShellShoccar-jpn/Parsrs](https://github.com/ShellShoccar-jpn/Parsrs)
  - makrj.sh
  - parsrj.sh

## how to use

Please place the following files.

  * json2shvars.lib..sh
  * lib/makrj.sh
  * lib/parsrj.sh

Please set the following variables.

  * _J2SVLIB
    * Path to makrj.sh, parsrj.sh

## sample

### sample code
```
# set 3rdparty Lib path
_J2SVLIB="Path/to/lib"

# include lib
_FNCFILE="${_J2SVDIR}/json2shvars.lib.sh"
. ${_FNCFILE}

# make configuration, load and delete
_configfile=$(mkConf ${_jsonfile} ${_tag})
. ${_configfile}
rm ${_configfile}
```

### run include sample.sh

```sh ./sample.sh sample.json staging _TOKEN```

```sh ./sample.sh sample.json production _TOKEN```
