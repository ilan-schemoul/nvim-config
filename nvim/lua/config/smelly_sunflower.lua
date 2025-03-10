M = {}

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

-- TODO: add function to remove all logs with fix_me_now
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
    end
    vim.api.nvim_buf_set_lines(0, row, row, false, { log })
    if above then
      vim.fn.feedkeys("k")
    else
      vim.fn.feedkeys("j")
    end
    vim.fn.feedkeys("==")
end

M.insert_above = function() insert_log(true) end
M.insert_below = function() insert_log(false) end

M.clean = function()
  vim.cmd("g/fix_me_now/d")
end

M.clean_all_buffers = function()
  vim.cmd("bufdo silent! g/fix_me_now/d")
  vim.cmd("bufdo silent! w")
end

return M
