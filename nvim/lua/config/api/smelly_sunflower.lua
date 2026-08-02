-- Throwaway debug logs, tagged with `fix_me_now` so they can all be wiped again.
local M = {}

local function random_adjective()
    local words = {
    "beautiful", "witty", "wicked", "confusing", "rich", "new", "strange",
    "rocky", "circular", "helpful", "competent", "smelly", "stable", "grumpy",
    "devoted", "smart", "muscular", "graceful", "scary", "safe", "wooden", "sleepy",
    "tardy", "hungry", "strange", "hopeful", "proud", "new", "dainty", "royal",
    "arrogant", "round", "efficient", "youthful", "cumbersome", "fickle",
    "mild", "expensive", "small", "rude", "generous", "courageous",
    "zany", "thin", "round", "oval", "dark", "hot", "modern", "petite",
    "weary",
    }
    return words[math.random(1, #words)]
end

local function random_emojis()
  local emojis = {
    cat='🐱',  dog='🐶',  mouse='🐭',  hamster='🐹',  rabbit='🐰',  wolf='🐺',  frog='🐸',  tiger='🐯',  koala='🐨',  bear='🐻',  pig='🐷',  pig_nose='🐽',  cow='🐮',  boar='🐗',  monkey_face='🐵',  monkey='🐒',  horse='🐴',  racehorse='🐎',  camel='🐫',  sheep='🐑',  elephant='🐘',  panda_face='🐼',  snake='🐍',  bird='🐦',  baby_chick='🐤',  hatched_chick='🐥',  hatching_chick='🐣',  chicken='🐔',  penguin='🐧',  turtle='🐢',  bug='🐛',  honeybee='🐝',  ant='🐜',  beetle='🪲',  snail='🐌',  octopus='🐙',  tropical_fish='🐠',  fish='🐟',  whale='🐳',  dolphin='🐬',  ram='🐏',  rat='🐀',  water_buffalo='🐃',  dragon='🐉',  goat='🐐',  rooster='🐓',  ox='🐂',  dragon_face='🐲',  blowfish='🐡',  crocodile='🐊',  dromedary_camel='🐪',  leopard='🐆',  poodle='🐩',  paw_prints='🐾',  bouquet='💐',  cherry_blossom='🌸',  tulip='🌷',  four_leaf_clover='🍀',  rose='🌹',  sunflower='🌻',  hibiscus='🌺',  maple_leaf='🍁',  leaves='🍃',  fallen_leaf='🍂',  herb='🌿',  mushroom='🍄',  cactus='🌵',  palm_tree='🌴',  deciduous_tree='🌳',  chestnut='🌰',  seedling='🌱',  blossom='🌼',
  }

  local keyset={}
  local n=0
  for k,v in pairs(emojis) do
    n=n+1
    keyset[n]=k
  end

  local key = keyset[math.random(1, n)]
  return key, emojis[key]
end

local function insert_log(above)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    if above then
      row = row - 1
    end
    local word, emoji = random_emojis()
    local payload =  emoji .. ' ' .. random_adjective() .. ' ' .. word .. ' fix_me_now'

    local log = ''
    local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
    if ft == "c" then
      log = 'logger_warning(&_G.logger, "' .. payload .. ' %s:%d' .. '", __FILE__, __LINE__);'
    elseif ft == "python" then
      log = 'LOGGER.warning("' .. payload .. '")'
    elseif ft == "cs" then
      log = 'System.Console.WriteLine("' .. payload .. '");'
    end
    vim.api.nvim_buf_set_lines(0, row, row, false, { log })

    if above then
      vim.fn.feedkeys("k")
    else
      vim.fn.feedkeys("j")
    end

    vim.schedule(function()
      vim.fn.feedkeys("==")
    end)
end

M.insert_log_above = function() insert_log(true) end
M.insert_log_below = function() insert_log(false) end

M.clean_logs = function()
  vim.cmd("g/fix_me_now/d")
end

M.clean_all_logs = function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local readonly = vim.api.nvim_get_option_value("readonly", { buf = bufnr })

    if (vim.api.nvim_buf_is_valid(bufnr)
        and vim.api.nvim_get_option_value("modifiable", { buf = bufnr })
        and not readonly
        and vim.api.nvim_get_option_value("buftype", { buf = bufnr }) == '') then
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local deleted_lines = 0
      for i, line in ipairs(lines) do
        if string.match(line, "fix_me_now") then
          local line_to_delete = i - deleted_lines
          vim.api.nvim_buf_set_lines(bufnr, line_to_delete - 1, line_to_delete, false, {})
          deleted_lines = deleted_lines + 1
        end
      end

      if vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)[1] ~= nil and vim.api.nvim_buf_get_name(bufnr) ~= '' then

        vim.api.nvim_buf_call(bufnr, function() vim.cmd('w') end)
      end
    end
  end
end

-- Wrap a function so calling it notifies how long it took
M.profile = function(fn)
  return function(...)
    local start = vim.uv.hrtime()
    local ret = fn(...)
    vim.notify(("It took %.3fms"):format((vim.uv.hrtime() - start) / 1e6))

    return ret
  end
end

return M
