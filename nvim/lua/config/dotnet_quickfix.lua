-- WARN: fully vibe coded (because parsing sucks, and nvim error format is nightmare inducing)

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

local function report_build(code, output, items)
  local has_errors = vim.iter(items):any(function(item)
    return item.type == "e"
  end)

  if has_errors then
    vim.cmd("copen")
  elseif code ~= 0 then
    -- Failed with nothing parseable: no project here, restore failure, crash.
    vim.notify(output ~= "" and output or "dotnet build failed", vim.log.levels.ERROR)
  elseif #items > 0 then
    vim.notify(("dotnet build succeeded (%d warning(s))"):format(#items))
  else
    vim.notify("dotnet build succeeded")
  end
end

vim.api.nvim_create_user_command("DotnetBuild", function()
  local spinner = require("fidget").progress.handle.create({ title = "dotnet build" })

  vim.system({ "dotnet", "build" }, { text = true }, function(obj)
    vim.schedule(function()
      spinner:finish()

      local output = (obj.stdout or "") .. (obj.stderr or "")
      local lines = dedupe(vim.split(output, "\n"))


      vim.fn.setqflist({}, " ", { lines = lines, efm = build_efm, title = "dotnet build" })
      report_build(obj.code, output, vim.fn.getqflist())
    end)
  end)
end, {})

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
vim.api.nvim_create_user_command("Dtest", function(cmd)
  local log_path = cmd.fargs[1] or "/tmp/test_logs"

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
end, { nargs = "?", complete = "file" })
