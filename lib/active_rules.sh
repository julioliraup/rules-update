#!/bin/sh

rules_dir="$1"
sid_bruto="$2"

_make_regex(){
  if [ -z "$sid_bruto" ]; then
    str_component=""
  else
    str_all=$(echo "$sid_bruto" | awk '{for(i=1;i<=NF;i++) printf "sid:"$i"|" }' | sed 's/.$//')
    str_component="/$str_all/!"
  fi
  echo "$str_component"
}

if [ "$1" = "--help" ]; then
  printf "Script para alterar todas as regras\n"
  printf "------------------\n"
  printf "Uso: $0 Rules_dir Sids [opcao]\n\n"
  printf "VALOR\t\t\t SIGNIFICADO\n"
  printf "Rules_dir\t\t Diretorio em que estao as rules\n"
  printf "Sids\t\t\t IDs de assinaturas separado com espaco e definido com aspas. Ex: \"23013 123020 123002\"\n"
  printf "\t\t\t Esses sao os IDs que nao serao alterado"
  printf "[opcao]\t\t Caso queira mudar drop para alert basta usar --alert\n"
  printf "\t\t\t Isso e opcional\n"
  exit 0
fi

if [ "$3" = "--alert" ]; then
  sed -i '' "$( _make_regex ) s/drop/alert/g" "$rules_dir"/*.rules
else
  sed -i '' "$( _make_regex ) s/alert/drop/g" "$rules_dir"/*.rules
fi

