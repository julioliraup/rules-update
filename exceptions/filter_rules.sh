#!/bin/sh
# script para verificar falso positivo na rede 
# Ele listará todos os IDs que contém em alerta
# Se executado em um ambiente controlado sem estar
# sob ataque é possivel identificar falsos positivos

logfile=""

if [ "$1" == "" ];
then
  logfile="/var/log/suricata/suricata_*/alerts.log"
else
  logfile="$1"
fi

ids=$(cat $logfile | awk '{print $3}' | cut -d: -f2)

unique_ids=$(echo "$ids" | tr ' ' '\n' | sort -u | tr '\n' ' ')

echo "$unique_ids"
