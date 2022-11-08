--[[
	Transformer.lua
	A transforming meta-flow originally built for packer.

	TL;DR you have a function to which you want to eventually pass a table.
	With this, you can construct the table piece by piece.
	It will finally call out once you pass () or a string.
	The string will *prepend* itself to the object.

	Merging rules are a bit complicated:
	For tables, we merge the ipairs in order (left to right).
		The final '' is an exception.
	Then we merge the map-like keys recursively.
	If the target is a table but the merged key isn't, we append it.
	Otherwise we always overwrite.
]]--

---@diagnostic disable-next-line: unused-vararg
local function tables(...)
	for i=1,select('#') do
		if type(select(i)) ~= 'table' then return false end
	end
	return true
end

local function imerge(t1, t2) -- mutates t1
	for _, v in ipairs(t2) do table.insert(t1, v) end
end

local bigmerge -- forward declaration

local function kmerge(t1, t2) -- mutates t2
	for k, v in pairs(t2) do
		if type(k) == 'number' and k >= 1 and k <= #t1 then
			-- skip, we did this in imerge
		else
			if t1[k] and type(t1[k]) == 'table' then
				if type(v) == 'table' then
					t1[k] = bigmerge(t1[k], v)
				else
					table.insert(t1[k], v)
				end
			else
				t1[k] = v
			end
		end
	end
end

bigmerge = function(t1, t2)
	assert(tables(t1, t2))
	local out = {}
	imerge(out, t1)
	imerge(out, t2)
	kmerge(out, t1)
	kmerge(out, t2)
	return out
end

local function tgen(use) return function (self, obj)
	if obj == nil then return use(self) end

	if type(obj) == 'string' then
		local out = { obj }
		imerge(out, self)
		kmerge(out, self)
		return setmetatable(out, getmetatable(self))()
	elseif type(obj) == 'table' then
		local out = bigmerge(self, obj)
		return setmetatable(out, getmetatable(self))

	else
		error 'Invalid argument.'
	end

end end

return function(use)
	return setmetatable({}, { __call = tgen(use) })
end
