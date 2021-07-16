VERSION = '0.1.0'

local micro  = import 'micro'
local config = import 'micro/config'
local util   = import 'micro/util'

function init()
	micro.SetStatusInfoFn 'textcount.characters'
	micro.SetStatusInfoFn 'textcount.lines'
	micro.SetStatusInfoFn 'textcount.paragraphs'
	micro.SetStatusInfoFn 'textcount.sentences'
	micro.SetStatusInfoFn 'textcount.words'
	config.MakeCommand('wc.c', charactersi, config.NoCompete)
	config.MakeCommand('wc.l', linesi, 		config.NoComplete)
	config.MakeCommand('wc.p', paragraphsi, config.NoComplete)
	config.MakeCommand('wc.s', sentencesi, 	config.NoComplete)
	config.MakeCommand('wc.w', wordsi, 		config.NoComplete)

	config.MakeCommand('wc', wc, config.NoComplete)
end

local function selections(b)
	local str = ''
	for _, c in b:GetCursors()() do
		if c:HasSelection() then
			str = str .. ' ' .. util.String(c:GetSelection())
		end
	end
	return str
end

-- utils
local function pattern(b, pat)
	-- if there is a selection, we use it, else we use b:Bytes()
	local str = selections(b)
	if str == '' then str = util.String(b:Bytes()) end
	local _, n = str:gsub(pat, '')
	return n
end

local function genb(...)
	local args = {...}
	return function(b)
		local total = 0
		for _, v in ipairs(args) do
			total = total + pattern(b, v)
		end
		return tostring(total)
	end
end

local function geni(f, label)
	return function(bp)
		local data = f(bp.Buf)
		micro.InfoBar():Message(data .. ' ' .. label)
	end
end

-- functions
characters  = genb '.'
charactersi = geni(characters, 'Characters')

lines  = genb '\n'
linesi = geni(lines, 'Lines')

paragraphs  = genb('\n\n', '$') -- $ handles the final paragraph
paragraphsi = geni(paragraphs, 'Paragraphs')

sentences  = genb '%.[^%.]'
sentencesi = geni(sentences, 'Sentences')

words  = genb '%S+'
wordsi = geni(words, 'Words')

-- user-defined patterns
function wc(bp, args)
	local total = 0
	for _, v in args() do
		total = total + pattern(bp.Buf, v)
	end
	micro.InfoBar():Message(tostring(total))
end
