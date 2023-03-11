#!/bin/bash

source "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/deps/shell/src/import.sh"
import io system timer

new Timer timer

dirs=$(ls -d */ | cut -d '/' -f 1)

for dir in $dirs; do
  [[ -d "$dir/.git" ]] || continue

  info "Updating '$dir'..."
  cd $dir || exit 1
  git fetch origin $(git symbolic-ref --short -q HEAD) >/dev/null || error "Failed to update repo '$dir'"
  cd .. || exit 1
done

good "Done ($(timer.getSeconds) sec)"

delete timer

