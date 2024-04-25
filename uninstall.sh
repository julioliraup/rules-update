#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
    echo "Este script precisa ser executado como root."
    exit 1
fi

DEFAULT_DIR="/usr/local/www"
if [ "$1" = "-d" ]; then
  [ -z "$2" ] && exit 1
  DEFAULT_DIR="$2"
fi

# Check if exists
[ -d "$DEFAULT_DIR" ] && echo "Identificando arquivo padrão em $DEFAULT_DIR"

rm -rfv /usr/local/pkg/suricata/active_rules.sh
if [ "$?" -eq 0 ]; then
  echo "[OK] Deletado script /usr/local/pkg/suricata/active_rules.sh"
fi

if mv -v "backup/suricata_rules.php" "$DEFAULT_DIR/suricata/suricata_rules.php"; then
  echo "Restaurando arquivo php ao original"
  echo "[OK] REMOÇÃO BEM SUCEDIDA"
else
  echo "[ERRO] BACKUP NÃO ENCONTRADO. VERIFIQUE A VERSÃO DO SEU SURICATA E BAIXE DIRETAMENTE:"
  echo " → https://raw.githubusercontent.com/pfsense/FreeBSD-ports/devel/security/pfSense-pkg-suricata/files/usr/local/www/suricata/suricata_rules.php"
fi

