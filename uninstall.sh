#!/bin/bash

# description: Install the interface update-rules action
# author: Julio Lira
# Versão: 1.0
# Check user root
#
if [ "$(id -u)" -e 0 ]; then
    echo "Este script precisa ser executado como root."
    exit 1
fi

DEFAULT_DIR="/usr/local/www"
if [ "$1" == "-d" ]
then
  [ "$2" =! "" ] && exit 1
  DEFAULT_DIR="$2"
fi

# Check if exits
[ -d $DEFAULT_DIR ] && echo -e "...\t\t Identificando arquivo padrao em $DEFAULT_DIR";

rm -rfv /usr/local/pkg/suricata/active_rules.sh
[ "$?" == "0" ] && echo -e "[OK]\t...\t Deletado script /usr/local/pkg/suricata/active_rules.sh";

mv -v "backup/suricata_rules.php" "$DEFAULT_DIR/suricata/suricata_rules.php" && echo -e "\t...\t Restaurando arquivo php ao original"

if [ "$?" == "0" ]
then
  echo "[OK] REMOCAO BEM SUCEDIDA"
else
  echo -e "[ER] BACKUP NAO ENCONTRADO. VERIFIQUE A VERSAO DO SEU SURICATA E BAIXE DIRETAMENTE\n → https://raw.githubusercontent.com/pfsense/FreeBSD-ports/devel/security/pfSense-pkg-suricata/files/usr/local/www/suricata/suricata_rules.php"
fi
