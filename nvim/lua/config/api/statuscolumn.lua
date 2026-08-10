local M = {}

local function get_line_signs(buf, lnum)
  local existing_sign
  local extmarks = vim.api.nvim_buf_get_extmarks(buf, -1, { lnum - 1, 0 }, { lnum - 1, -1 }, {
    details = true,
    type = "sign",
  })
  for _, mark in ipairs(extmarks) do
    local sign = mark[4]

    if sign then
      local priority = sign.priority or 0

      if not existing_sign or priority > (existing_sign.priority or 0) then
        existing_sign = {
          text = sign.sign_text,
          texthl = sign.sign_hl_group,
          priority = priority,
          type = "sign",
        }
      end
    end
  end

  return existing_sign
end

local function first_col_empty(bufnr, lnum)
  local line = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)[1]
  return #line == 0 or line:sub(1, 1) == " "
end

local small_icon_equivalent = {
  -- LSP
  ['󰅚 '] = '✕',
  ['󰀪 '] = '▲',
  ['󰋽 '] = 'ℹ',
  ['󰌶 '] = 'h',
  -- TODO
  [' '] = '!',
  [' '] = '✔',
  [' '] = '⚠',
  [' '] = '⁈',
  [' '] = 'ℹ',
  [' '] = '⏲',
  ['⏲ '] = '⏲',
}

local function handle_large_icons(text, bufnr, lnum)
  local space = 148
  local whatever = 32

  -- Gitsigns can return empty string as second character, trim it
  if string.byte(text, 2) == space or string.byte(text, 2) == whatever then
    return vim.fn.strcharpart(text or "", 0, 1)
  end

  if not first_col_empty(bufnr, lnum) then
    local small_icon = small_icon_equivalent[text]
    -- If no small icon, we just show it on two width (entire status column will be
    -- 2 columns so no overlap)
    return small_icon or vim.fn.strcharpart(text or "", 0, 2)
  else
    local first_char = text:sub(1, 1)
    -- Gitsigns shows deleted sign + a number right after. We cannot use the trick
    -- of trimming to one character (see next block) as it's two distinct characters.
    -- So we accept that status column will take 2 columns.
    if first_char == "‾" or first_char == "_" then
      return vim.fn.strcharpart(text or "", 0, 2)
    end

    -- We will display the entire icon, but trick Nvim to think it spans
    -- only on one column to not make the entire statuscolumn be 2 width.
    return vim.fn.strcharpart(text or "", 0, 1)
  end
end

local function render_sign(sign, bufnr, lnum)
  if not sign then
    return ""
  end

  local text

  -- If we an icon that takes 2 cols, we will trim it so it never takes 2 cols.
  -- Otherwise, the entire status column takes 2 cols which I hate
  if #sign.text >= 2 then
    text = handle_large_icons(sign.text, bufnr, lnum)
  else
    text = vim.fn.strcharpart(sign.text or "", 0, 1)
  end

  if sign.texthl then
    return "%#" .. sign.texthl .. "#" .. text .. "%*"
  end
  return text
end

-- 2000 lines ~= 600ms (but using profiling slow it down a bit)
_G.StatusColumn = function(bufnr, lnum)
  -- Priority: LSP, git, TODO (?)
  return render_sign(get_line_signs(bufnr, lnum), bufnr, lnum)
end

function M.enable()
  vim.opt.statuscolumn = [[%!v:lua.StatusColumn(bufnr(),v:lnum)]]
end

function M.set_signcolumn(set)
  if set then
    M.enable()
  else
    vim.wo[0].statuscolumn = ""
  end
end

function M.set_number_signcolumn(set)
  if set then
    vim.wo[0].statuscolumn = "%l"
  else
    M.enable()
  end
end


return M
