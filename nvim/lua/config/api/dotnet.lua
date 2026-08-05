local M = {}

-- WARN: fully vibe coded (because parsing sucks, and nvim error format is nightmare inducing)

local services = {
  'anvil', 'solid', 'bank-listener', 'block-listener', 'exchange-listener',
  'block-monitor', 'eva', 'postgres', 'redis', 'mock',
}

-- msbuild diagnostics: /path/Foo.cs(12,5): error CS1002: ; expected [/path/Foo.csproj]
-- The trailing %-G discards everything else (restore chatter, banners, timings).
local build_efm = "%f(%l\\,%c): %t%*[a-zA-Z] %m,%-G%.%#"

-- msbuild repeats a diagnostic once per project referencing the broken one.
local function dedupe(lines)
  local seen = {}

  return vim.tbl_filter(function(line)
    local is_new = not seen[line]
    seen[line] = true
    return is_new
  end, lines)
end

local function report_build(label, code, output, items)
  local has_errors = vim.iter(items):any(function(item)
    return item.type == "e"
  end)

  if has_errors then
    vim.cmd("copen")
  elseif code ~= 0 then
    -- Failed with nothing parseable: no project here, restore failure, crash.
    vim.notify(output ~= "" and output or (label .. " failed"), vim.log.levels.ERROR)
  elseif #items > 0 then
    vim.notify(("%s succeeded (%d warning(s))"):format(label, #items))
    vim.cmd("cclose")
  else
    vim.notify(label .. " succeeded")
    vim.cmd("cclose")
  end
end

function M.build()
  local spinner = require("fidget").progress.handle.create({ title = "dotnet build" })

  vim.system({ "dotnet", "build" }, { text = true }, function(obj)
    vim.schedule(function()
      spinner:finish()

      local output = (obj.stdout or "") .. (obj.stderr or "")
      local lines = dedupe(vim.split(output, "\n"))

      vim.fn.setqflist({}, " ", { lines = lines, efm = build_efm, title = "dotnet build" })
      report_build("dotnet build", obj.code, output, vim.fn.getqflist())
    end)
  end)
end

-- `rebuild` (from aspire) adds [build] and sometimes timestamp. Remove them
local function strip_rebuild_prefix(line)
  local timestamp = "^%d%d%d%d%-%d%d%-%d%dT[%d:.]+Z%s*"
  return line:gsub("^%[build%]%s*", ""):gsub(timestamp, "")
end

local function rebuild(service)
  local spinner = require("fidget").progress.handle.create({ title = "Building " .. service })

  vim.system({ vim.o.shell, "-c", "rebuild " .. service }, { text = true }, function(obj)
    vim.schedule(function()
      spinner:finish()

      local output = (obj.stdout or "") .. (obj.stderr or "")
      local lines = dedupe(vim.tbl_map(strip_rebuild_prefix, vim.split(output, "\n")))

      vim.fn.setqflist({}, " ", { lines = lines, efm = build_efm, title = "rebuild " .. service })
      report_build("rebuild " .. service, obj.code, output, vim.fn.getqflist())
    end)
  end)
end

function M.rebuild()
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  require("telescope.pickers")
  .new({}, {
    prompt_title = "Rebuild unit",
    finder = require("telescope.finders").new_table({ results = services }),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local entry = action_state.get_selected_entry()

        rebuild(entry.value)
      end)
      return true
    end,
  })
  :find()
end

-- "at Method() in /path/File.cs:362" -> file, line. We skip if no local source (libraries).
local function frame_location(line)
  local file, lnum = line:match("^%s*at .+ in (.+):(%d+)$")

  if file and not file:find("\\", 1, true) and not file:find("/obj/", 1, true) then
    return file, tonumber(lnum)
  end
end

-- One entry per "failed <Test> (Xms)" header, at its first local stack frame.
local function parse_test_failures(lines)
  local items = {}
  local pending -- failure awaiting a frame

  for _, line in ipairs(lines) do
    local name = line:match("^failed (.+)$")

    if name then
      pending = { text = name, type = "e" }
      table.insert(items, pending)
    elseif pending then
      local file, lnum = frame_location(line)

      if file then
        pending.filename, pending.lnum = file, lnum
        pending = nil
      end
    end
  end

  return items
end

-- Reads TUnit console output as teed to /tmp/test_logs by the `dtest` fish
-- function. Takes an optional path, for the archived /tmp/test_logs_<date>.
function M.parse_test_file(path)
  local log_path = path or "/tmp/test_logs"

  if vim.fn.filereadable(log_path) == 0 then
    vim.notify("No test log found at " .. log_path, vim.log.levels.WARN)
    return
  end

  local items = parse_test_failures(vim.fn.readfile(log_path))
  vim.fn.setqflist({}, " ", { items = items, title = "dtest" })

  if #items > 0 then
    vim.cmd("copen")
  else
    vim.notify("All tests passed")
  end
end

return M
