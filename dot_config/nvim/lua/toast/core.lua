-- [nfnl] Compiled from fnl/toast/core.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("toast.table")
local insert = _local_1_["insert"]
local function dec(n)
  return (n - 1)
end
local function inc(n)
  return (n + 1)
end
local function drop(n, xs)
  local out = {}
  for i, v in ipairs(xs) do
    if (i > n) then
      insert(out, v)
    else
    end
  end
  return out
end
local function empty_3f(xs)
  return (0 == #xs)
end
local function first(xs)
  return xs[1]
end
local function last(xs)
  return xs[#xs]
end
local function group(n, xs)
  if empty_3f(xs) then
    return {}
  else
    local ll
    local function _3_(_241)
      return #last(_241)
    end
    ll = _3_
    local donext
    local function _4_(_241)
      return (ll(_241) == n)
    end
    donext = _4_
    local out = {{}}
    for _, v in ipairs(xs) do
      if donext(out) then
        insert(out, {})
      else
      end
      out = insert(last(out), v, out)
    end
    return out
  end
end
local function map(f, xs)
  local out = {}
  for _, v in ipairs(xs) do
    local mapped = f(v)
    local function _7_()
      if (0 == select("#", mapped)) then
        return nil
      else
        return mapped
      end
    end
    out = insert(out, _7_())
  end
  return out
end
return {dec = dec, inc = inc, drop = drop, ["empty?"] = empty_3f, group = group, first = first, last = last}
