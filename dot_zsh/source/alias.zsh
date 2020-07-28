alias cat=bat
alias cp='cp --reflink=auto'
alias dif='colordiff -u'
alias dit='docker run --rm -it'
alias drun='dit -v "$PWD":/pwd:Z -w /pwd'
alias g=genius
alias less='less -R'
alias m=micro
alias ossh='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR'
alias tar=bsdtar
alias vim=nvim
alias yaegi='rlwrap yaegi'

alias bshar='bsdtar --format=shardump'
alias shar='bsdtar --format=shar'
