type -qf ugrep || exit
alias grep 'ugrep -G'
alias egrep 'ugrep -E'
alias fgrep 'ugrep -F'
alias pgrep 'ugrep -P'
alias xgrep 'ugrep -W'

alias zgrep 'ugrep -zG'
alias zegrep 'ugrep -zE'
alias zfgrep 'ugrep -zF'
alias zpgrep 'ugrep -zP'
alias zxgrep 'ugrep -zW'

alias xdump 'ugrep -X ""'

type -qf ug || exit
alias uq 'ug -Q'
alias ux 'ug -UX'
alias uz 'ug -z'
