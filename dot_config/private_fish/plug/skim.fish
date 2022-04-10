type -qf sk || return
set -gx SKIM_DEFAULT_COMMAND 'fd --type f || rg --files || find .'
