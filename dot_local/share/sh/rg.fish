. hascmd rg || return
test -f ~/.config/ripgrep.conf && set -gx RIPGREP_CONFIG_PATH ~/.config/ripgrep.conf
