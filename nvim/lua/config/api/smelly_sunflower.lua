-- Throwaway debug logs, tagged with `fix_me_now` so they can all be wiped again.
local M = {}

math.randomseed(vim.uv.hrtime())

local adjectives = {
    "epice", "maudit", "feroce", "dodu", "louche", "bancal", "loufoque", "piquant", "grincheux", "sournois", "chaotique", "branlant",
    "fourbe", "bougon", "revolte", "diabolique", "capricieux", "desordonne", "espiegle", "malicieux",
}

local emojis = {
    raton = "🦝", clown = "🤡", fantome = "👻", licorne = "🦄", poulpe = "🐙", cactus = "🌵", cerveau = "🧠", monstre = "🍝", chat = "🐈",
    bombe = "💣", taco = "🌮", zombie = "🧟", extraterrestre = "👽", diable = "😈", sirene = "🧜", robot = "🤖", pingouin = "🐧",
    banane = "🍌", tatou = "🦔", dragon = "🐉", hippopotame = "🦛", crocodile = "🐊", serpent = "🐍", scorpion = "🦂", araignee = "🕷️",
    abeille = "🐝", papillon = "🦋", escargot = "🐌", tortue = "🐢", lezard = "🦎", requin = "🦈", baleine = "🐳", dauphin = "🐬",
    poisson = "🐟", renard = "🦊", loup = "🐺", ours = "🐻", panda = "🐼", koala = "🐨", tigre = "🐯", lion = "🦁", singe = "🐵",
    cochon = "🐷", mouton = "🐑", vache = "🐮", poulet = "🐔", hibou = "🦉", chauvesouris = "🦇", souris = "🐭", hamster = "🐹",
}

local function random_emojis()
    local keyset={}
    local n=0
    for k in pairs(emojis) do
        n=n+1
        keyset[n]=k
    end

    local desc = keyset[math.random(1, n)]
    return desc, emojis[desc]
end

local used_combos = {}

local function random_combo()
    local adjective = adjectives[math.random(1, #adjectives)]
    local emoji_desc, emoji = random_emojis()
    local combo_key = adjective .. '|' .. emoji_desc

    local total = vim.tbl_count(emojis) + vim.tbl_count(adjectives)
    assert(vim.tbl_count(used_combos) < total, "All emoji/adjectives combo used")

    if used_combos[combo_key] then
        return random_combo()
    end

    used_combos[combo_key] = true
    return adjective, emoji_desc, emoji
end

local function insert_log(above)
    local row = vim.api.nvim_win_get_cursor(0)[1]
    if above then
        row = row - 1
    end
    local adjective, emoji_desc, emoji = random_combo()
    local payload =  emoji .. ' ' .. emoji_desc .. ' ' .. adjective .. ' fix_me_now'

    local log
    local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
    if ft == "c" then
        log = 'logger_warning(&_G.logger, "' .. payload .. ' %s:%d' .. '", __FILE__, __LINE__);'
    elseif ft == "python" then
        log = 'LOGGER.warning("' .. payload .. '")'
    elseif ft == "cs" then
        log = 'System.Console.WriteLine("' .. payload .. '");'
    else
        vim.notify("No debug log template for filetype: " .. ft, vim.log.levels.ERROR)
        return
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

function M.insert_log_above() insert_log(true) end
function M.insert_log_below() insert_log(false) end

function M.clean_logs()
    vim.cmd("g/fix_me_now/d")
end

function M.clean_all_logs()
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

return M
