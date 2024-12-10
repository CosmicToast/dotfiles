set -Uuq OPAMROOT || set -Uu OPAMROOT ~/.local/ocaml
setux OPAMROOT

test -r $OPAMROOT/opam-init/init.fish
and source $OPAMROOT/opam-init/init.fish >/dev/null 2>/dev/null
or true
