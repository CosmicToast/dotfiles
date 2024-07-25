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
  if swap then
    return {line1 = (1 - el), line2 = sl}
  else
    return {line1 = (1 - sl), line2 = el}
  end
end
local function maplines(f)
  local function _8_(opts)
    local opts0 = location(opts)
    local argp
    local function _9_(_241)
      local _10_ = opts0.line1
      local _11_ = opts0.line2
      local function _12_(...)
        return _241(buf, _10_, _11_, true, ...)
      end
      return _12_
    end
    argp = _9_
    local setl = argp(vim.api.nvim_buf_set_lines)
    local getl = argp(vim.api.nvim_buf_get_lines)
    local function _13_()
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
    return setl(_13_())
  end
  return _8_
end
local _2bqf
local function _15_(_241)
  local _16_ = _241
  if (_16_ == "") then
    return _241
  else
    local function _17_()
      local s = _16_
      return s:match("^[%s>]")
    end
    if ((nil ~= _16_) and _17_()) then
      local s = _16_
      return (">" .. s)
    elseif (nil ~= _16_) then
      local s = _16_
      return ("> " .. s)
    else
      return nil
    end
  end
end
_2bqf = _15_
local _qf
local function _19_(_241)
  local _20_ = _241
  local function _21_()
    local s = _20_
    return s:match("^> ")
  end
  if ((nil ~= _20_) and _21_()) then
    local s = _20_
    return s:sub(3)
  else
    local function _22_()
      local s = _20_
      return s:match("^>")
    end
    if ((nil ~= _20_) and _22_()) then
      local s = _20_
      return s:sub(2)
    elseif true then
      local _ = _20_
      return _241
    else
      return nil
    end
  end
end
_qf = _19_
local _2bquote = maplines(_2bqf)
local _quote = maplines(_qf)
vim.api.nvim_buf_create_user_command(buf, "MdQuote", _2bquote, {range = true})
vim.api.nvim_buf_create_user_command(buf, "MdDeQuote", _quote, {range = true})
vim.keymap.set({"n", "x"}, ">", _2bquote, {buffer = true, desc = "increase quote level of selection"})
return vim.keymap.set({"n", "x"}, "<", _quote, {buffer = true, desc = "decrease quote level of selection"})
