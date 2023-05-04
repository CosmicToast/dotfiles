-- allow running code unconditionally before or after plugins / noplugins are loaded
local function doif(path)
	local cpath = vim.fn.stdpath 'config' .. '/'
	if vim.fn.filereadable(cpath .. path) > 0 then
		dofile(cpath .. path)
	end
end

-- leader, localleader, options
doif 'pre.lua'

-- plugins
if vim.fn.executable 'git' == 0 then
	doif 'noplugins.lua'
else
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
	  vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	  })
	end
	vim.opt.rtp:prepend(lazypath)
	require 'lazy'.setup("plugins", {})
	require 'bindings'
	vim.cmd [[colorscheme starlight]]
end

-- custom file associations etc
doif 'post.lua'
