-- [nfnl] Compiled from lsp/gopls.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(buf, cb)
  local function _2_()
    local modr = vim.fs.root(buf, "go.mod")
    local _3_
    if modr then
      _3_ = vim.fs.root(modr, "go.work")
    else
      _3_ = nil
    end
    return (_3_ or modr)
  end
  return cb(_2_())
end
return {cmd = {"gopls"}, filetypes = {"go", "gomod", "gowork", "gosum"}, root_dir = _1_, settings = {autoformat = true, gopls = {analyses = {unusedparams = true, unusedwrite = true, nilness = true}, gofumpt = true, semanticTokens = true, staticcheck = true}}}
