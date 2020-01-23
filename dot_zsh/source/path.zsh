export CARGO_HOME=~/.local/cargo
export DENO_DIR=~/.local/deno
export GOPATH=~/.local/go
export LUAROCKS_CONFIG=~/.config/luarocks/config.lua

path+=(
    ~/bin
    ~/.local/cargo/bin
    ~/.local/go/bin
    ~/.local/yarn/bin
    ~/.gem/ruby/*/bin(N)
)

if (( $+commands[luarocks] )); then
    path+=( $(luarocks path --lr-bin) )
    eval $(luarocks path --no-bin)
fi
if (( $+commands[opam] )); then
    eval $(opam env)
fi
if (( $+commands[yarn] )) && [[ ! -f ~/.yarnrc ]]; then
    yarn config set global-folder ~/.local/yarn/global
    yarn config set prefix ~/.local/yarn
fi
