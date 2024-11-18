-- [nfnl] Compiled from fnl/plugins/init.fnl by https://github.com/Olical/nfnl, do not edit.
local conjureft = {"clojure", "fennel", "hy", "janet", "julia", "lisp", "racket", "scheme"}
local function _1_(_, opts)
  for k, v in pairs(opts) do
    vim.g[("conjure#" .. k)] = v
  end
  return nil
end
return {{"folke/lazy.nvim", version = false}, {"Olical/nfnl", ft = "fennel"}, {"stevearc/dressing.nvim", opts = {}}, {"Olical/conjure", branch = "main", config = _1_, ft = conjureft, opts = {["mapping#prefix"] = "<localleader>e", ["extract#tree_sitter#enabled"] = true, filetypes = conjureft, ["filetype#fennel"] = "conjure.client.fennel.stdio", ["filetype#janet"] = "conjure.client.janet.stdio"}}, {"tpope/vim-repeat"}}
