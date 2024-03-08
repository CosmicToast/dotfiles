. hascmd luarocks || return
set -x LUA_CPATH (luarocks path --lr-cpath)
set -x LUA_PATH  (luarocks path --lr-path)";./?.lua"
