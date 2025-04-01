local M = {}
local last_edits = require("config/last_edits")
-- TODO: REMOVE
last_edits.auto()

local function prequire(m)
  local ok, err = pcall(require, m)
  if not ok then return nil, err end
  return err
end

local get_cache = function()
  local cacher_config = prequire("vectorcode.config")

  if cacher_config then
    local cacher = cacher_config.get_cacher_backend()
    return cacher.query_from_cache(0)
  end

  return nil
end

M.qwen_template = {
    prompt = function(pref, suff)
      local prompt_message = ""

      local cache = get_cache()
      if cache then
        for _, file in ipairs(cache) do
          prompt_message = prompt_message .. "<|file_sep|>" .. file.path .. "\n" .. file.document
        end
      end

      return prompt_message
        .. "<|fim_prefix|>"
        .. pref
        .. "<|fim_suffix|>"
        .. suff
        .. "<|fim_middle|>"
    end,
    suffix = false,
}

M.gemini_template = {
  system = {
    template = '{{{prompt}}}\n{{{guidelines}}}\n{{{n_completion_template}}}\n{{{repo_context}}}\n{{{last_edits}}}',
    repo_context = [[9. Additional context from other files in the repository will be enclosed in <repo_context> tags. Each file will be separated by <file_separator> tags, containing its relative path and content.]],
  },
  chat_input = {
    template = '{{{last_edits}}}\n{{{repo_context}}}\n{{{language}}}\n{{{tab}}}\n<contextBeforeCursor>\n{{{context_before_cursor}}}<cursorPosition>\n<contextAfterCursor>\n{{{context_after_cursor}}}',
    last_edits = function(_, _)
      return '<last_edits>\n' .. last_edits.get_last_edits() .. '\n</last_edits>'
    end,
    repo_context = function(_, _, _)
      local cache_result = get_cache()
      local prompt_message = ''
      if cache_result then
        for _, file in ipairs(cache_result) do
          prompt_message = prompt_message
          .. '<file_separator>'
          .. file.path
          .. '\n'
          .. file.document
        end
      end
      if prompt_message ~= '' then
        prompt_message = '<repo_context>\n' .. prompt_message .. '\n</repo_context>'
      end
      return prompt_message
    end,
  },
}

return M
