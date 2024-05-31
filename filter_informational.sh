#!/bin/sh
# script para verificar falso positivo na rede 
# Ele listará todos os IDs que contém são da
# categoria de INFO ou POLICY
logfile=""

if [ "$1" == "" ];
then
  logfile="/usr/local/share/suricata/rules/*"
else
  logfile="$1"
fi

grep -E '(former_category (INFO|POLICY)|(signature_severity Informational|ET INAPPROPRIATE |ET GAMES |ET CHAT ))' $logfile | grep -o 'sid:[0-9]*;' | sed 's/sid:/1:/;s/;//'
