# a bunch of items pollute ~ with history files
# and they all want different stuff to not do that!
# I want all my history in ~/.local/share/history/, so…
set -Uuq RLWRAP_HOME || set -Uu RLWRAP_HOME ~/.local/share/history
set -Uuq LESSHISTFILE || set -Uu LESSHISTFILE $RLWRAP_HOME/less
set -Uuq NODE_REPL_HISTORY || set -Uu NODE_REPL_HISTORY $RLWRAP_HOME/node
set -Uuq PSQL_HISTORY || set -Uu PSQL_HISTORY $RLWRAP_HOME/psql
set -Uuq PYTHON_HISTORY || set -Uu PYTHON_HISTORY $RLWRAP_HOME/python
set -Uuq SQLITE_HISTORY || set -Uu SQLITE_HISTORY $RLWRAP_HOME/sqlite
set -Uuq USQL_HISTORY || set -Uu USQL_HISTORY $RLWRAP_HOME/usql

setux RLWRAP_HOME LESSHISTFILE NODE_REPL_HISTORY PSQL_HISTORY PYTHON_HISTORY SQLITE_HISTORY
