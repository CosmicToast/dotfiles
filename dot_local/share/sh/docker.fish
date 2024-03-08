if . hascmd podman
    alias docker=podman
else if . hascmd docker
else
    return
end

alias dit='docker run -it --rm'
alias drun='dit -v (pwd):/pwd:Z -w /pwd'
