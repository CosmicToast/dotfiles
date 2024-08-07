-- [nfnl] Compiled from fnl/toast/table.fnl by https://github.com/Olical/nfnl, do not edit.
local function from_pairs(t, _3fmut)
  local out = (_3fmut or {})
  for _, _1_ in ipairs(t) do
    local k = _1_[1]
    local v = _1_[2]
    out[k] = v
  end
  return out
end
local function insert(t, ...)
  table.insert(t, ...)
  return t
end
local function concat(...)
  local out = {}
  for _, xs in ipairs({...}) do
    for _0, v in ipairs(xs) do
      insert(out, v)
    end
  end
  return out
end
local unpack = (table.unpack or unpack)
return {["from-pairs"] = from_pairs, insert = insert, unpack = unpack, concat = concat}
