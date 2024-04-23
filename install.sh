#!/bin/bash

# description: Install the interface update-rules action
# author: Julio Lira
# Versão: 1.0

# Check user root
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

mv -v lib/active_rules.sh /usr/local/pkg/suricata/active_rules.sh
[ "$?" == "0" ] && echo -e "[OK]\t...\t Script de alteracao: /usr/local/pkg/suricata/active_rules.sh";

mv -v "$DEFAULT_DIR/suricata/suricata_rules.php" "backup/" && echo -e "\t...\t backup de antiga pagina para backup/"
mv -v "./suricata_rules.php" "$DEFAULT_DIR/suricata/suricata_rules.php" && echo -e "\t...\t suricata_rules.php foi substituido com sucesso"

if [ "$?" == "0" ]
then
  echo "[OK] INSTALACAO BEM SUCEDIDA"
else
  echo -e "[ER] DOWNLOAD NAO REALIZADO VOCE PODE IMPLEMENTAR MANUALMENTE.\n → https://raw.githubusercontent.com/julioliraup/FreeBSD-ports/devel/security/pfSense-pkg-suricata/files/usr/local/www/suricata/suricata_rules.php"
fi
