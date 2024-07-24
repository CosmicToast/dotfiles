-- [nfnl] Compiled from fnl/bindings/init.fnl by https://github.com/Olical/nfnl, do not edit.
for _, v in ipairs({"builtins", "plugins"}) do
  require(("bindings." .. v))
end
return (require("which-key")).add({{"<leader>e", vim.diagnostic.open_float, desc = "diag float"}, {"<leader>q", vim.diagnostic.setloclist, desc = "diag locations"}, {"[d", vim.diagnostic.goto_prev, desc = "prev diag"}, {"]d", vim.diagnostic.goto_next, desc = "next diag"}})
