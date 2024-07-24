-- [nfnl] Compiled from fnl/toast/table.fnl by https://github.com/Olical/nfnl, do not edit.
local function from_pairs(t, _3fmut)
  local out = (_3fmut or {})
  for _, _1_ in ipairs(t) do
    local _each_2_ = _1_
    local k = _each_2_[1]
    local v = _each_2_[2]
    out[k] = v
  end
  return out
end
local function insert(t, ...)
  table.insert(t, ...)
  return t
end
return {["from-pairs"] = from_pairs, insert = insert}
