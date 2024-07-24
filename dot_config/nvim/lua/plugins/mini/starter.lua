-- [nfnl] Compiled from fnl/plugins/mini/starter.fnl by https://github.com/Olical/nfnl, do not edit.
local starter = require("mini.starter")
local telescope = {{action = "Telescope commands", name = "Commands"}, {action = "Telescope find_files", name = "Files"}, {action = "Telescope help_tags", name = "Help tags"}, {action = "Telescope live_grep", name = "Live grep"}, {action = "Telescope oldfiles", name = "Old files"}}
for _, v in ipairs(telescope) do
  v.section = "Telescope"
end
return {items = {telescope, starter.sections.builtin_actions()}}
