# json2shvars
jsonファイル上の値をShellscript変数として登録するためのライブラリ。

## 必須Lib

- [@ShellShoccar-jpn/Parsrs](https://github.com/ShellShoccar-jpn/Parsrs)
  - makrj.sh
  - parsrj.sh

## 使い方

以下のファイルを配置してください

  * json2shvars.lib.sh
  * lib/makrj.sh
  * lib/parsrj.sh

利用するスクリプトで以下の変数を設定してください

  * _J2SVLIB
    * makrj.sh、parsrj.sh へのパス

## サンプル

### サンプル code
```
# 同梱ライブラリへのパスをセットします
_J2SVLIB="Path/to/lib"

# json2shvarsを読み込みます
_FNCFILE="${_J2SVDIR}/json2shvars.lib.sh"
. ${_FNCFILE}

# Configを作成、読み込み、削除します
_configfile=$(mkConf ${_jsonfile} ${_tag})
. ${_configfile}
rm ${_configfile}
```

### run include sample.sh

```sh ./sample.sh sample.json staging _TOKEN```

```sh ./sample.sh sample.json production _TOKEN```
