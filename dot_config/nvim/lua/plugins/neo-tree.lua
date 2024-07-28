-- [nfnl] Compiled from fnl/plugins/neo-tree.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return require("neo-tree.command").execute({toggle = true})
end
return {{"nvim-neo-tree/neo-tree.nvim", branch = "v3.x", cmd = "Neotree", dependencies = {"nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"}, keys = {{"<leader>n", _1_, desc = "Neotree"}}, opts = {}}}
