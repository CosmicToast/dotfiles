type -qf rg || return
if test -f ~/.config/ripgrep.conf
    set -gx RIPGREP_CONFIG_PATH ~/.config/ripgrep.conf
end
