-- [nfnl] Compiled from fnl/plugins/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local function gen(key, fun, desc)
  local function _1_()
    return (require("telescope.builtin"))[fun]()
  end
  return {("<leader>f" .. key), _1_, desc = desc}
end
local function _2_(_, opts)
  local ts = require("telescope")
  ts.setup(opts)
  return ts.load_extension("fzf")
end
return {{"nvim-telescope/telescope.nvim", cmd = "Telescope", config = _2_, dependencies = {"nvim-lua/plenary.nvim", {"nvim-telescope/telescope-fzf-native.nvim", build = "make"}}, keys = {gen("f", "find_files", "Find File"), gen("g", "live_grep", "Live Grep"), gen("b", "buffers", "Find Buffer"), gen("h", "help_tags", "Find Help"), gen("c", "commands", "Find Command"), gen("t", "treesitter", "Find Treesitter")}}}
