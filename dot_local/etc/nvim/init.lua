-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
local function doif(path)
  local path0 = (vim.fn.stdpath("config") .. "/" .. path)
  local do_3f = (0 < vim.fn.filereadable(path0))
  if do_3f then
    return dofile(path0)
  else
    return nil
  end
end
doif("pre.lua")
if (0 == vim.fn.executable("git")) then
  doif("noplugins.lua")
else
  local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
  local fstat = vim.loop.fs_stat(lazypath)
  if not fstat then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
  else
  end
  vim.opt.rtp:prepend(lazypath)
  require("lazy").setup("plugins", {})
  require("bindings")
  vim.cmd("colorscheme starlight")
end
return doif("post.lua")
