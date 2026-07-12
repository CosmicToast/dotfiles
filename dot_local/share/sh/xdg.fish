#!/bin/sh
set -q XDG_OPT         || set -l  XDG_OPT         ~/.local
set -q XDG_CONFIG_HOME || set -gx XDG_CONFIG_HOME $XDG_OPT/etc
set -q XDG_DATA_HOME   || set -gx XDG_DATA_HOME   $XDG_OPT/share
set -q XDG_STATE_HOME  || set -gx XDG_STATE_HOME  $XDG_OPT/var
set -q XDG_CACHE_HOME  || set -gx XDG_CACHE_HOME  $XDG_OPT/tmp

# XDG compatiblity settings for everything

set -gx BUN_INSTALL $XDG_OPT/bun

set -gx CLJ_CACHE  $XDG_CACHE_HOME/clojure
set -gx CLJ_CONFIG $XDG_CONFIG_HOME/clojure

set -gx DOTNET_CLI_HOME $XDG_OPT/dotnet

set -gx JULIA_DEPOT_PATH   $XDG_OPT/julia
set -gx JULIAUP_DEPOT_PATH $XDG_OPT/julia

set -gx OPAMROOT $XDG_OPT/ocaml

set -gx IPYTHONDIR            $XDG_OPT/python/ipython
set -gx JUPYTER_CONFIG_DIR    $XDG_OPT/python/jupyter
set -gx UV_PYTHON_BIN_DIR     $XDG_OPT/python/bin
set -gx UV_PYTHON_INSTALL_DIR $XDG_OPT/python/interpreters
set -gx UV_TOOL_BIN_DIR       $XDG_OPT/python/bin
set -gx UV_TOOL_DIR           $XDG_OPT/python/tools

set -gx CARGO_HOME  $XDG_OPT/rust
set -gx RUSTUP_HOME $XDG_OPT/rust

set -gx ZVM_PATH $XDG_OPT/zig

set -gx RLWRAP_HOME $XDG_STATE_HOME/history
set -gx LESSHIST_FILE     $RLWRAP_HOME/less
set -gx NODE_REPL_HISTORY $RLWRAP_HOME/node
set -gx PSQL_HISTORY      $RLWRAP_HOME/psql
set -gx PYTHON_HISTORY    $RLWRAP_HOME/python
set -gx SQLITE_HISTORY    $RLWRAP_HOME/sqlite
set -gx USQL_HISTORY      $RLWRAP_HOME/usql
