-- [nfnl] Compiled from fnl/plugins/init.fnl by https://github.com/Olical/nfnl, do not edit.
local conjureft = {"clojure", "fennel", "hy", "janet", "julia", "lisp", "racket", "scheme"}
local function _1_(_, opts)
  for k, v in pairs(opts) do
    vim.g[("conjure#" .. k)] = v
  end
  return nil
end
return {{"folke/lazy.nvim", version = false}, {"folke/snacks.nvim", lazy = false, opts = {indent = {enabled = true, scope = {enabled = false}}, input = {enabled = true}, quickfile = {enabled = true}}, priority = 1000}, {"Olical/nfnl", ft = "fennel"}, {"Olical/conjure", branch = "main", config = _1_, ft = conjureft, opts = {["mapping#prefix"] = "<localleader>e", ["extract#tree_sitter#enabled"] = true, filetypes = conjureft, ["filetype#janet"] = "conjure.client.janet.stdio"}}, {"tpope/vim-repeat"}}
