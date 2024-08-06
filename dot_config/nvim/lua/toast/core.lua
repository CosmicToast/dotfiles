-- [nfnl] Compiled from fnl/toast/core.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("toast.table")
local insert = _local_1_["insert"]
local unpack = _local_1_["unpack"]
local function dec(n)
  return (n - 1)
end
local function inc(n)
  return (n + 1)
end
local function empty_3f(xs)
  return (0 == #xs)
end
local function nil_3f(x)
  return (nil == x)
end
local function number_3f(n)
  return ("number" == type(n))
end
local function every_3f(pred, xs)
  local pass = true
  for _, x in ipairs(xs) do
    if not pass then break end
    pass = pred(x)
  end
  return pass
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
local function assoc(_3ft, ...)
  local t = (_3ft or {})
  local lt = inc(#t)
  local _let_7_ = {...}
  local k = _let_7_[1]
  local v = _let_7_[2]
  local xs = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_7_, 3)
  if (k == nil) then
  else
    local and_8_ = (nil ~= k)
    if and_8_ then
      local k0 = k
      and_8_ = (number_3f(k0) and (lt > k0))
    end
    if and_8_ then
      local k0 = k
      t[k0] = v
    else
      local and_10_ = (nil ~= k)
      if and_10_ then
        local k0 = k
        and_10_ = (number_3f(k0) and (k0 == lt))
      end
      if and_10_ then
        local k0 = k
        table.insert(t, v)
      else
        local _ = k
        t[k] = v
      end
    end
  end
  local _13_ = #xs
  if (_13_ == 0) then
    return t
  elseif (_13_ == 1) then
    return error("assoc expects even number of arguments after table, found odd number")
  else
    local _ = _13_
    return assoc(t, unpack(xs))
  end
end
local function map(f, xs)
  local out = {}
  for _, v in ipairs((xs or {})) do
    local mapped = f(v)
    local function _15_()
      if (0 == select("#", mapped)) then
        return nil
      else
        return mapped
      end
    end
    out = insert(out, _15_())
  end
  return out
end
return {dec = dec, inc = inc, ["empty?"] = empty_3f, ["nil?"] = nil_3f, ["number?"] = number_3f, ["every?"] = every_3f, drop = drop, first = first, last = last, group = group, assoc = assoc, map = map}
