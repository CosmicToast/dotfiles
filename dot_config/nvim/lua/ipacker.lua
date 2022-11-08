-- init packer = ipacker
-- returns packer or blackhole
-- sets ipacker global to # depending on bootstrap level
-- ipacker =
	-- 0 = no packer present
	-- 1 = bootstrapped just now
	-- 2 = already present
local fn = vim.fn
local ipath = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local repo  = 'https://github.com/wbthomason/packer.nvim'

ipacker = 0
if #fn.findfile('packer.lua', ipath .. '**') == 0 then
	if fn.executable 'git' == 0 then
		return require 'blackhole'
	end
	fn.system {'git', 'clone', '--depth', '1', repo, ipath}
	vim.cmd [[packloadall!]]
	ipacker = 1
else
	ipacker = 2
end

return require 'packer'
