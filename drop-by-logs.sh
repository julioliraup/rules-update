#!/bin/sh

logfile=""

_reader_log(){
	ids="$(cat $logfile | awk '{print $3}' | cut -d: -f2)"

	unique_ids="$(echo "$ids" | tr ' ' '\n' | sort -u | tr '\n' ' ' | sed 's/\[\*\*\]//g')"
	#unique_ids="$(echo "$ids" | tr ' ' '\n' | sort -u | sed 's/^/1:/')"

	printf "$unique_ids"
}

_make_regex(){
	sid_bruto="$1"
	if [ -z "$sid_bruto" ]; then
	  str_component=""
	else
	  str_all=$(echo "$sid_bruto" | awk '{for(i=1;i<=NF;i++) printf $i"|" }' | sed 's/.$//')
	  str_component="sid:($str_all)\;"
	fi
	echo "$str_component"
}

if [ "$1" == "" ];
then
  logfile="/var/log/suricata/suricata_*/alerts.log"
else
	if [ "$1" == "--help" ]
	then
		printf "Uso: $0 <log-file(s)> <rules-file(s)>"
		exit 0
	else
		logfile="$1"
	fi
fi

if [ "$2" == "" ];
then
  rulesFile="/usr/local/share/suricata/rules/*"
else
  rulesFile="$1"
fi

ids_except="$(_reader_log)"
grep -Ev $(_make_regex "$ids_except") $rulesFile | sed -n 's/.*sid:\([0-9]*\).*/\1/p' | sed 's/^/1:/' | sort -u

