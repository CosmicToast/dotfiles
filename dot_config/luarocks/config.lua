-- LuaRocks configuration

rocks_trees = {
   { name = "user", root = home .. "/.local/luarocks" };
   { name = "system", root = "/usr" };
}
lua_interpreter = "lua5.3";
variables = {
   LUA_DIR = "/usr";
   LUA_BINDIR = "/usr/bin";
}

home_tree = home .. "/.local/luarocks"
homeconfdir = home .. "/.config/luarocks"
