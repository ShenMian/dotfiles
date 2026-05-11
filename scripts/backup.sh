#!/bin/bash

source "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/deps/shell/src/import.sh"
import io system

backups_path="$PWD/backups"

backup()
{
  local timestamp=$(date +%s)
  local backup_name="$USER-$timestamp"
  local backup_path="$backups_path/$backup_name"

  info 'Sync from server'
  git pull &>/dev/null || error 'Failed to sync from server'

  new Timer timer
  
  info 'Back up'
  mkdir -p "$backup_path" || (error "Bakcup '$backup_name' already exists"; return 1)
  paths=("$HOME/.[^.]*")
  for path in $paths; do
    cp "$path" "$backup_path" &>/dev/null || warn "Some or all files are not backed up"
    rm -rf $(find "$backup_path" -name ".git")
  done
  info "Total size: $(du -hs "$backup_path" | cut -f 1)"

  info 'Sync to server'
  git add . >/dev/null || (error "Failed to add untracked files"; return 1)
  git commit -m "Add backup '$backup_name'" >/dev/null || (error "Failed to commit"; return 1)
  git push &>/dev/null || (error "Failed to push"; return 1)

  good "Succeed ($(timer.getSeconds) sec)"

  delete timer
}

requires git

backup
