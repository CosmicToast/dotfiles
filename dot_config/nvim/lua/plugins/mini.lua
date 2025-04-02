-- [nfnl] Compiled from fnl/plugins/mini.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(_, opts)
  for k, v in pairs(opts) do
    require(("mini." .. k)).setup(v)
  end
  return nil
end
return {{"echasnovski/mini.nvim", config = _1_, opts = {ai = {}, align = {}, basics = {}, bracketed = {indent = {options = {change_type = "diff"}}}, comment = {}, completion = {}, cursorword = {}, move = {}, splitjoin = {}, statusline = {}, tabline = {}, trailspace = {}}, version = false}}
