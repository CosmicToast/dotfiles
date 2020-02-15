#!/bin/zsh

subtrees=(
    dot_local/share/toasty st:toasty-zsh
)

for key val in ${(kv)subtrees}
do
    chezmoi source -- subtree pull -P $key $val master --squash
done
