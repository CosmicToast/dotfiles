-- [nfnl] Compiled from post.fnl by https://github.com/Olical/nfnl, do not edit.
local fts = {{extension = {janet = "janet"}}, {extension = {cls = "latex"}}}
for _, v in ipairs(fts) do
  vim.filetype.add(v)
end
return nil
