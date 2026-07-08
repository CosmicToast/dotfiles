-- [nfnl] Compiled from ftplugin/markdown_quote.fnl by https://github.com/Olical/nfnl, do not edit.
local buf = 0
local function location(opts)
  local sl
  local _2_
  do
    local t_1_ = opts
    if (nil ~= t_1_) then
      t_1_ = t_1_.line1
    else
    end
    _2_ = t_1_
  end
  sl = (_2_ or vim.fn.line("v"))
  local el
  local _5_
  do
    local t_4_ = opts
    if (nil ~= t_4_) then
      t_4_ = t_4_.line2
    else
    end
    _5_ = t_4_
  end
  el = (_5_ or vim.fn.line("."))
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
      local tbl_21_auto = {}
      local i_22_auto = 0
      for _, v in ipairs(getl()) do
        local val_23_auto = f(v)
        if (nil ~= val_23_auto) then
          i_22_auto = (i_22_auto + 1)
          tbl_21_auto[i_22_auto] = val_23_auto
        else
        end
      end
      return tbl_21_auto
    end
    return setl(_14_())
  end
  return _9_
end
local _2bqf
local function _16_(_241)
  if (_241 == "") then
    return _241
  else
    local and_17_ = (nil ~= _241)
    if and_17_ then
      local s = _241
      and_17_ = s:match("^[%s>]")
    end
    if and_17_ then
      local s = _241
      return (">" .. s)
    elseif (nil ~= _241) then
      local s = _241
      return ("> " .. s)
    else
      return nil
    end
  end
end
_2bqf = _16_
local _qf
local function _20_(_241)
  local and_21_ = (nil ~= _241)
  if and_21_ then
    local s = _241
    and_21_ = s:match("^> ")
  end
  if and_21_ then
    local s = _241
    return s:sub(3)
  else
    local and_23_ = (nil ~= _241)
    if and_23_ then
      local s = _241
      and_23_ = s:match("^>")
    end
    if and_23_ then
      local s = _241
      return s:sub(2)
    else
      local _ = _241
      return _241
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
