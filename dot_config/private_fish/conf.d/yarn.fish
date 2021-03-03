if type -qf yarn && ! test -f ~/.yarnrc
    yarn config set global-folder ~/.local/yarn/global
    yarn config set prefix ~/.local/yarn
end
