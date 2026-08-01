-- Named floating terminals backed by FTerm, kept alive across toggles.
local M = {}

M.terminals = {}

local create = function(terminal_type, cmd, opts)
  opts.env = opts.env or {}
  opts.env.IS_FTERM = "1"

  ---@diagnostic disable-next-line: missing-fields
  M.terminals[terminal_type] = require('FTerm'):new({
    ft = opts.ft or ("ft_" .. terminal_type),
    cmd = cmd,
    on_exit = opts.on_exit,
    ---@diagnostic disable-next-line: missing-fields
    dimensions = opts.dimensions or {
        height = 0.95,
        width = 0.95
    },
    env = opts.env,
    border = opts.border,
    z_index = 50,
  })
end

local toggle_or_create_term = function(terminal_type, cmd, opts)
  local buffer_terminal

  if M.terminals[terminal_type] ~= nil and not opts.force_new then
    buffer_terminal = M.terminals[terminal_type]:toggle()
  else
    create(terminal_type, cmd, opts)
    buffer_terminal = M.terminals[terminal_type]:open()
  end

  vim.keymap.set("t", "<A-q>", function()
    M.terminals[terminal_type]:toggle()
  end, { buffer = buffer_terminal.buf, desc = "Toggle " .. terminal_type .. " terminal" })
end

---@param opts? { q?: boolean, force_new?: boolean, on_exit?: function }
M.toggle_or_create = function(terminal_type, cmd, opts)
  opts = opts or {}

  local old_term = M.terminals[terminal_type]

  if opts.force_new and old_term then
    -- XXX: buggy as hell. I spent a very long time debugging this s*** and
    -- well nvim is buggy or IDK. But stopping a job randomly kills unrelated
    -- jobs (like my shell running inside nvim). Adding a defer_fn to terminal
    -- creation avoid being killed.
    old_term:exit()
  end

  toggle_or_create_term(terminal_type, cmd, opts)
end

-- One sticky fish terminal per cwd, cd'd into it via PRIO_HOME_DIR_STARTUP (see fish config.fish)
M.fish_in_cwd = function(cwd)
  -- used in ft, we cannot use paths (:/ etc.) so we hash it
  local cwd_hash = cwd and vim.fn.sha256(cwd)
  local terminal_type = "fish_" .. (cwd_hash or "default")
  local env = { PRIO_HOME_DIR_STARTUP = cwd }

  M.toggle_or_create(terminal_type, { "fish" }, {
    env = env,
    ft = 'ft_fish',
    dimensions = {
        height = 0.8,
        width = 0.6
    },
  })
end

M.kill = function(terminal_type)
  -- Not supported yet: https://github.com/numToStr/FTerm.nvim/issues/110
  M.terminals[terminal_type]:exit()
  M.terminals[terminal_type] = nil
end

M.toggle_existing = function(terminal_type)
  if not M.terminals[terminal_type] then
    vim.notify('Sticky terminal does not exist', vim.log.levels.ERROR)
    return
  end

  M.terminals[terminal_type]:toggle()
end

return M
