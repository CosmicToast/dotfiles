-- [nfnl] Compiled from ftplugin/markdown_quote.fnl by https://github.com/Olical/nfnl, do not edit.
local buf = 0
local function location(opts)
  local sl
  local function _1_()
    local t_2_ = opts
    if (nil ~= t_2_) then
      t_2_ = (t_2_).line1
    else
    end
    return t_2_
  end
  sl = (_1_() or vim.fn.line("v"))
  local el
  local function _4_()
    local t_5_ = opts
    if (nil ~= t_5_) then
      t_5_ = (t_5_).line2
    else
    end
    return t_5_
  end
  el = (_4_() or vim.fn.line("."))
  local swap = (sl > el)
  local dec
  local function _7_(_241)
    return (_241 - 1)
  end
  dec = _7_
  if swap then
    return {line1 = dec(el), line2 = sl}
  else
    return {line1 = dec(sl), line2 = el}
  end
end
local function maplines(f)
  local function _9_(opts)
    local opts0 = location(opts)
    local argp
    local function _10_(_241)
      local _11_ = opts0.line1
      local _12_ = opts0.line2
      local function _13_(...)
        return _241(buf, _11_, _12_, true, ...)
      end
      return _13_
    end
    argp = _10_
    local setl = argp(vim.api.nvim_buf_set_lines)
    local getl = argp(vim.api.nvim_buf_get_lines)
    local function _14_()
      local tbl_17_auto = {}
      local i_18_auto = #tbl_17_auto
      for _, v in ipairs(getl()) do
        local val_19_auto = f(v)
        if (nil ~= val_19_auto) then
          i_18_auto = (i_18_auto + 1)
          do end (tbl_17_auto)[i_18_auto] = val_19_auto
        else
        end
      end
      return tbl_17_auto
    end
    return setl(_14_())
  end
  return _9_
end
local _2bqf
local function _16_(_241)
  local _17_ = _241
  if (_17_ == "") then
    return _241
  else
    local function _18_()
      local s = _17_
      return s:match("^[%s>]")
    end
    if ((nil ~= _17_) and _18_()) then
      local s = _17_
      return (">" .. s)
    elseif (nil ~= _17_) then
      local s = _17_
      return ("> " .. s)
    else
      return nil
    end
  end
end
_2bqf = _16_
local _qf
local function _20_(_241)
  local _21_ = _241
  local function _22_()
    local s = _21_
    return s:match("^> ")
  end
  if ((nil ~= _21_) and _22_()) then
    local s = _21_
    return s:sub(3)
  else
    local function _23_()
      local s = _21_
      return s:match("^>")
    end
    if ((nil ~= _21_) and _23_()) then
      local s = _21_
      return s:sub(2)
    elseif true then
      local _ = _21_
      return _241
    else
      return nil
    end
  end
end
_qf = _20_
local _2bquote = maplines(_2bqf)
local _quote = maplines(_qf)
vim.api.nvim_buf_create_user_command(buf, "MdQuote", _2bquote, {range = true})
vim.api.nvim_buf_create_user_command(buf, "MdDeQuote", _quote, {range = true})
vim.keymap.set({"n", "x"}, ">", _2bquote, {buffer = true, desc = "increase quote level of selection"})
return vim.keymap.set({"n", "x"}, "<", _quote, {buffer = true, desc = "decrease quote level of selection"})
