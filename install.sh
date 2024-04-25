#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "Este script precisa ser executado como root."
    exit 1
fi

DEFAULT_DIR="/usr/local/www"
if [ "$1" = "-d" ]; then
    [ -z "$2" ] && exit 1
    DEFAULT_DIR="$2"
fi

[ -d "$DEFAULT_DIR" ] && echo "Identificando arquivo padrão em $DEFAULT_DIR..."

mv -v lib/active_rules.sh /usr/local/pkg/suricata/active_rules.sh
if [ "$?" -eq 0 ]; then
    echo "[OK] Script de alteração movido para /usr/local/pkg/suricata/active_rules.sh"
else
    echo "[ERRO] Falha ao mover o script de alteração."
fi

mv -v "$DEFAULT_DIR/suricata/suricata_rules.php" "backup/" && echo "Backup da antiga página realizado com sucesso em backup/"
mv -v "./suricata_rules.php" "$DEFAULT_DIR/suricata/suricata_rules.php" && echo "suricata_rules.php foi substituído com sucesso"

if [ "$?" -eq 0 ]; then
    echo "[OK] INSTALAÇÃO BEM SUCEDIDA"
else
    echo "[ERRO] ARQUIVO NÃO SUBSTITUIDO, VOCE PODE TENTAR MANUALMENTE"
    echo " → https://raw.githubusercontent.com/julioliraup/FreeBSD-ports/devel/security/pfSense-pkg-suricata/files/usr/local/www/suricata/suricata_rules.php"
fi
