#!/bin/zsh

# example:
# dot_local/share/toasty https://github.com/cosmictoast/toasty-zsh
subtrees=(
)

for key val in ${(kv)subtrees}
do
    chezmoi source -- subtree pull -P $key $val master --squash
done
