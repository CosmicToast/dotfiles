set -Uuq CARGO_HOME  || set -Uu CARGO_HOME  ~/.local/rust
set -Uuq RUSTUP_HOME || set -Uu RUSTUP_HOME ~/.local/rust
setux CARGO_HOME RUSTUP_HOME
