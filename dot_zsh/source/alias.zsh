alias cp='cp --reflink=auto'
alias dit='docker run --rm -it' drun='dit -v "$PWD":/pwd:Z -w /pwd'
alias h='ht -Fb' ht='ht -F'
alias g=genius
alias less='less -R'
alias m=micro
alias ossh='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR'
alias tar=bsdtar
alias vim=nvim
alias yaegi='rlwrap yaegi'

alias bshar='bsdtar --format=shardump' shar='bsdtar --format=shar'
