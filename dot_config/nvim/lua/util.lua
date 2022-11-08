-- hasplug
local function hp(plug)
	return packer_plugins and
		packer_plugins[plug] and
		packer_plugins[plug].loaded
end

return {
	hp = hp,
}
