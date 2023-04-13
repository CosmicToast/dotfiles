local starter = require 'mini.starter'

local function telescope()
	local builtinf = starter.sections.telescope()
	local builtin  = builtinf()
	table.remove(builtin, 1)
	return function() return builtin end
end

return {
	items = {
		telescope(),
		starter.sections.builtin_actions(),
	},
}
