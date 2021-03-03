type -qf podman
and alias docker podman

if type -q docker
    alias dit  'docker run --rm -it'
    alias drun 'dit -v (pwd):/pwd:Z -w /pwd'
end
