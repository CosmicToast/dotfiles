local api = vim.api
local fn  = vim.fn

local buffer = 0 -- operate on current buffer

local function location(opts)
	-- if called from a command, we don't have event info
	if not opts then
		opts = {
			line1 = fn.line 'v',
			line2 = fn.line '.',
		}
	end

	if opts.line1 > opts.line2 then
		opts.line1, opts.line2 = opts.line2, opts.line1
	end

	-- nvim api lines are zero-based end-exclusive
	opts.line1 = opts.line1 - 1
	return opts
end

local function mdquote(opts)
	opts = location(opts)

	-- 1. get all of the matching lines
	local lines = api.nvim_buf_get_lines(buffer, opts.line1, opts.line2, true)

	-- 2. edit them appropriately
	for i, line in ipairs(lines) do
		-- prepend a ">" and a " ",
		-- unless the first character was already ">" or whitespace
		-- so prepend " " first unless the above is true
		if line:match '^$' then
		elseif line:match '^[%s>]' then
			lines[i] = '>' .. line
		else
			lines[i] = '> ' .. line
		end
	end

	-- 3. insert them back
	api.nvim_buf_set_lines(buffer, opts.line1, opts.line2, true, lines)
end

local function mddequote(opts)
	opts = location(opts)

	-- see mdquote for the steps
	local lines = api.nvim_buf_get_lines(buffer, opts.line1, opts.line2, true)

	for i, line in ipairs(lines) do
		-- if the line starts with a "> ", remove both
		-- elseif the line starts with a ">", remove that
		-- TODO: I don't handle \t-based quoting
		if line:match '^> ' then
			lines[i] = line:sub(3)
		elseif line:match '^>' then
			lines[i] = line:sub(2)
		end
	end

	api.nvim_buf_set_lines(buffer, opts.line1, opts.line2, true, lines)
end

api.nvim_buf_create_user_command(buffer, 'MdQuote', mdquote, { range = true })
api.nvim_buf_create_user_command(buffer, 'MdDeQuote', mddequote, { range = true })
vim.keymap.set({'n', 'x'}, '>', mdquote, {
	buffer = true,
	desc = 'increase quote level of selection',
})
vim.keymap.set({'n', 'x'}, '<', mddequote, {
	buffer = true,
	desc = 'decrease quote level of selection',
})
