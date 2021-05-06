type -qf podman
and alias docker podman

if type -q docker
    alias dit  'docker run -it --rm'
    alias drun 'dit -v (pwd):/pwd:Z -w /pwd'
end
