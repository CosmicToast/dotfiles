#!/bin/sh
set -q XDG_CONFIG_HOME || set -gx XDG_CONFIG_HOME ~/.local/etc
set -q XDG_DATA_HOME   || set -gx XDG_DATA_HOME   ~/.local/share
set -q XDG_STATE_HOME  || set -gx XDG_STATE_HOME  ~/.local/var
set -q XDG_CACHE_HOME  || set -gx XDG_CACHE_HOME  ~/.local/tmp

# XDG compatiblity settings for everything

set -gx BUN_INSTALL ~/.local/bun

set -gx CLJ_CACHE  $XDG_CACHE_HOME/clojure
set -gx CLJ_CONFIG $XDG_CONFIG_HOME/clojure

set -gx DOTNET_CLI_HOME ~/.local/dotnet

set -gx JULIA_DEPOT_PATH   ~/.local/julia
set -gx JULIAUP_DEPOT_PATH ~/.local/julia

set -gx OPAMROOT ~/.local/ocaml

set -gx IPYTHONDIR            ~/.local/python/ipython
set -gx JUPYTER_CONFIG_DIR    ~/.local/python/jupyter
set -gx UV_PYTHON_BIN_DIR     ~/.local/python/bin
set -gx UV_PYTHON_INSTALL_DIR ~/.local/python/interpreters
set -gx UV_TOOL_BIN_DIR       ~/.local/python/bin
set -gx UV_TOOL_DIR           ~/.local/python/tools

set -gx CARGO_HOME  ~/.local/rust
set -gx RUSTUP_HOME ~/.local/rust

set -gx ZVM_PATH ~/.local/zig

set -gx RLWRAP_HOME $XDG_STATE_HOME/history
set -gx LESSHIST_FILE     $RLWRAP_HOME/less
set -gx NODE_REPL_HISTORY $RLWRAP_HOME/node
set -gx PSQL_HISTORY      $RLWRAP_HOME/psql
set -gx PYTHON_HISTORY    $RLWRAP_HOME/python
set -gx SQLITE_HISTORY    $RLWRAP_HOME/sqlite
set -gx USQL_HISTORY      $RLWRAP_HOME/usql
