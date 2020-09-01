if (( $+commands[luarocks] )); then
    PATH="$PATH:$(luarocks path --lr-bin)" # luarocks puts :s in the output
    eval $(luarocks path --no-bin)
fi
if (( $+commands[opam] )); then
    eval $(opam env)
fi
if (( $+commands[yarn] )) && [[ ! -f ~/.yarnrc ]]; then
    yarn config set global-folder ~/.local/yarn/global
    yarn config set prefix ~/.local/yarn
fi

# high priority
path=( ~/bin $path )

# low priority
path+=(
    ~/Applications
    ~/.local/cargo/bin
    ~/.local/go/bin
    ~/.local/yarn/bin
    ~/.gem/ruby/*/bin(N)
)
