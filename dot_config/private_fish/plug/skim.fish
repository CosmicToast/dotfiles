type -qf sk || exit
set -gx SKIM_DEFAULT_COMMAND 'fd --type f || rg --files || find .'
