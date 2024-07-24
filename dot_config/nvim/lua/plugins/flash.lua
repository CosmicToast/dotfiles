-- [nfnl] Compiled from fnl/plugins/flash.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("flash")).jump()
end
local function _2_()
  return (require("flash")).treesitter()
end
local function _3_()
  return (require("flash")).remote()
end
local function _4_()
  return (require("flash")).treesitter_search()
end
local function _5_()
  return (require("flash")).toggle()
end
return {{"folke/flash.nvim", event = "VeryLazy", keys = {{"s", _1_, desc = "Flash", mode = {"n", "x", "o"}}, {"S", _2_, desc = "Flash Treesitter", mode = {"n", "x", "o"}}, {"r", _3_, desc = "Remote Flash", mode = "o"}, {"R", _4_, desc = "Flash Treesitter Search", mode = {"o", "x"}}, {"<c-s>", _5_, desc = "Toggle Flash Search", mode = "c"}}, opts = {modes = {search = {enabled = false}}}}}
