local M = {}
local pairs = { [")"] = "(", ["]"] = "[", ["}"] = "{" }
local opens = { ["("] = true, ["["] = true, ["{"] = true }

-- This is an explicit operation: normal editing must never uncomment text.
function M.split_closers(bufnr, first, last)
  local lines = vim.api.nvim_buf_get_lines(bufnr, first - 1, last, false)
  local result, stack = {}, {}
  local in_string = false

  for _, line in ipairs(lines) do
    local indent, marker, spacing, code = line:match("^(%s*)(;+)(%s*)(.*)$")
    local split
    if code then
      local escaped = false
      local pos = 1
      while pos <= #code do
        local char = code:sub(pos, pos)
        if in_string then
          if escaped then
            escaped = false
          elseif char == "\\" then
            escaped = true
          elseif char == '"' then
            in_string = false
          end
        elseif char == '"' then
          in_string = true
        elseif char == ";" then
          break
        elseif char == "\\" then
          -- Clojure character literals, including \), are not delimiters.
          pos = pos + 1
          while code:sub(pos + 1, pos + 1):match("[%w_-]") do
            pos = pos + 1
          end
        elseif opens[char] then
          stack[#stack + 1] = char
        elseif pairs[char] then
          if #stack == 0 then
            if code:sub(pos):match("^[%)%]%}%s,]+$") then
              split = pos
            end
            break
          elseif stack[#stack] ~= pairs[char] then
            error("Mismatched delimiters in commented form")
          else
            table.remove(stack)
          end
        end
        pos = pos + 1
      end
    else
      stack = {}
      in_string = false
    end

    if split then
      result[#result + 1] = indent
        .. marker
        .. spacing
        .. code:sub(1, split - 1):gsub("%s+$", "")
      result[#result + 1] = indent .. code:sub(split)
    else
      result[#result + 1] = line
    end
  end

  if not vim.deep_equal(lines, result) then
    vim.api.nvim_buf_set_lines(bufnr, first - 1, last, false, result)
  end
end

function M.setup()
  local group =
    vim.api.nvim_create_augroup("ClojureCommentCommands", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "clojure",
    callback = function(args)
      vim.api.nvim_buf_create_user_command(
        args.buf,
        "ClojureSplitCommentClosers",
        function(range)
          local ok, err =
            pcall(M.split_closers, args.buf, range.line1, range.line2)
          if not ok then
            vim.notify(err, vim.log.levels.WARN)
          end
        end,
        {
          range = true,
          desc = "Split trailing closers from commented Clojure forms",
        }
      )
    end,
  })
end

return M
