local config = import 'micro/config'

local function wantwords(ft)
	return ft == 'markdown'
		or ft == 'asciidoc'
end

local function appendsep(s, a)
	if s ~= '' then s = s .. ' | ' end
	return s .. a
end

function onBufferOpen(b)
	if wantwords(b:FileType()) then
		local format = config.GetGlobalOption 'statusformatr'
		local add    = '$(textcount.words) Words'
		if not string.find(format, add) then
			b:SetOption('statusformatr', appendsep(format, add))
		end
	end
end
