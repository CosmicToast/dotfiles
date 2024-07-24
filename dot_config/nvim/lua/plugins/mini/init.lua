-- [nfnl] Compiled from fnl/plugins/mini/init.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(_, opts)
  for k, v in pairs(opts) do
    do end (require(("mini." .. k))).setup(v)
  end
  return nil
end
local function _2_()
  return {ai = {}, align = {}, basics = {}, bracketed = {indent = {options = {change_type = "diff"}}}, comment = {}, completion = {}, cursorword = {}, indentscope = {}, move = {}, splitjoin = {}, statusline = {}, tabline = {}, trailspace = {}}
end
return {{"echasnovski/mini.nvim", config = _1_, opts = _2_, version = false}}
