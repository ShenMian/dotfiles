#!/bin/bash

source "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/deps/shell/src/import.sh"
import io system timer types

backups_path="$PWD/backups"

print_records()
{
  new Timer timer

  info 'Sync from server'
  if ! git pull &>/dev/null; then
    error 'Failed to sync from server'
  fi

  local backup_names=`ls $backups_path`

  printf '%3s %-12s %-31s %-5s\n' '#' 'User' 'Time' 'Size'
  printf '%3s %-12s %-31s %-5s\n' '-' '----' '----' '----'

  declare -i n=0
  for name in $backup_names; do
    backup_records[$n]="$n ${name//-/ } $name"
    local record=(${backup_records[$n]})
    if [ "${record[1]}" = "$USER" ]; then
      printf "${Green}%3s %-12s %-31s %-5s\n${Color_off}" "${record[0]}" "${record[1]}" "`date -d @${record[2]}`" "`du -hs $backups_path/${record[3]} | cut -f 1`"
    else
      printf "%3s %-12s %-31s %-5s\n" "${record[0]}" "${record[1]}" "`date -d @${record[2]}`" "`du -hs $backups_path/${record[3]} | cut -f 1`"
    fi
    n+=1
  done

  echo "${#backup_records[@]} row in set ($(timer.getSeconds) sec)"

  delete timer
}

restore()
{
  print_records
  printf '# to restore> '
  read num

  if [ -z "$num" ] || [ "$num" -ge "${#backup_records[@]}" ]; then
    error 'The # is invalid'
    return 1
  fi

  local record=(${backup_records[$num]})
  local backup_path="$backups_path/${backup_records[3]}"
  while true; do
    read -p "Do you wish to restore #$num backup? [y/N] " yn
    case $yn in
        [Yy]* ) break;;
        [Nn] | * )
          warn 'Operation cancelled'
          return 1;;
    esac
  done

  info 'Restoring backup'
  cp -r "$backup_path" ~ &>/dev/null || warn 'Some or all files are not restored'
  good 'Succeed'
}

requires git

restore
