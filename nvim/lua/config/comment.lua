local processing = false
local opens = { ["("] = true, ["["] = true, ["{"] = true }
local closes = { [")"] = true, ["]"] = true, ["}"] = true }

---
-- Analyzes a single commented line to find a split point, considering the
-- parenthesis balance carried over from previous lines in the block.
---
-- @param line (string) The line content.
-- @param comment_marker (string) The language's comment marker (e.g., ";").
-- @param starting_balance (number) The parenthesis balance from preceding lines.
-- @return table: The new line(s) that should replace the original one.
-- @return number: The final balance after parsing this entire line.
---
local function analyze_line(line, comment_marker, starting_balance)
  local indent, line_content = line:match("^(%s*)(.*)$")
  local code_part =
    line_content:match("^%s*" .. vim.pesc(comment_marker) .. "%s?(.*)$")

  -- If line isn't a comment or has no code, no change is possible.
  if not code_part then
    return { line }, starting_balance
  end

  local level = starting_balance
  local split_pos = nil
  local pos = 1

  while pos <= #code_part do
    local char = code_part:sub(pos, pos)
    if opens[char] then
      level = level + 1
    elseif closes[char] then
      level = level - 1
      -- A closer is "trailing" if it makes the balance dip BELOW the balance
      -- of the entire block before this line was processed.
      if level < 0 and not split_pos then
        split_pos = pos
      end
    end
    pos = pos + 1
  end

  if split_pos then
    local before_split = code_part:sub(1, split_pos - 1):match("^(.-)%s*$")
    local after_split = code_part:sub(split_pos)

    local new_commented_line = indent .. comment_marker .. " " .. before_split
    local new_uncommented_line = indent .. after_split
    return { new_commented_line, new_uncommented_line }, level
  end

  -- No split, but we still normalize the line and return the new balance.
  local normalized_line = indent .. comment_marker .. " " .. code_part
  return { normalized_line }, level
end

---
-- The main processor. Uses a two-pass approach for correctness.
-- Pass 1 (Analysis): Top-down to correctly track parenthesis balance.
-- Pass 2 (Modification): Bottom-up to safely apply buffer changes.
---
local function process_range(start_line, end_line)
  if processing or vim.bo.buftype ~= "" then
    return
  end

  processing = true
  local buf = vim.api.nvim_get_current_buf()

  vim.schedule(function()
    vim.api.nvim_command("silent! undojoin")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end

    local original_lines =
      vim.api.nvim_buf_get_lines(buf, start_line - 1, end_line, false)
    local comment_marker = (vim.bo[buf].commentstring or ""):match(
      "^(.-)%s*%%s"
    )
    if not comment_marker then
      processing = false
      return
    end

    -- === Pass 1: Analysis (Top to Bottom) ===
    local balance = 0
    local planned_changes = {} -- Stores the calculated new lines for each original line.
    for i, line in ipairs(original_lines) do
      local new_lines, new_balance = analyze_line(line, comment_marker, balance)
      planned_changes[i] = new_lines
      balance = new_balance
    end

    -- === Pass 2: Modification (Bottom to Top) ===
    for i = #original_lines, 1, -1 do
      local line_num = start_line + i - 1
      local original_line = original_lines[i]
      local new_lines = planned_changes[i]

      -- Only modify the buffer if the lines are actually different.
      if #new_lines ~= 1 or new_lines[1] ~= original_line then
        vim.api.nvim_buf_set_lines(
          buf,
          line_num - 1,
          line_num,
          false,
          new_lines
        )
      end
    end

    processing = false
  end)
end

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  pattern = "*",
  callback = function(args)
    -- In insert mode, find the full comment block context.
    -- Otherwise, trust the '[ and '] marks for visual/operator changes.
    local mode = vim.api.nvim_get_mode().mode
    if not (mode:find("i") or mode:find("ic")) then
      local start_mark = vim.api.nvim_buf_get_mark(args.buf, "[")
      local end_mark = vim.api.nvim_buf_get_mark(args.buf, "]")
      if start_mark[1] ~= 0 and end_mark[1] ~= 0 then
        process_range(start_mark[1], end_mark[1])
      end
      return
    end

    -- For Insert mode changes:
    local buf = args.buf
    local comment_marker = (vim.bo[buf].commentstring or ""):match("^(.-)%%s")
    if not comment_marker then
      return
    end
    comment_marker = comment_marker:match("^(.-)%s*$")

    local lnum = vim.api.nvim_win_get_cursor(0)[1]
    local line_content =
      vim.api.nvim_buf_get_lines(buf, lnum - 1, lnum, false)[1]

    -- Early exit if the current line isn't a comment
    local is_comment_pattern = "^%s*" .. vim.pesc(comment_marker)
    if not line_content or not line_content:match(is_comment_pattern) then
      return
    end

    -- Find start of contiguous comment block by scanning upwards
    local start_line = lnum
    while start_line > 1 do
      local prev_line = vim.api.nvim_buf_get_lines(
        buf,
        start_line - 2,
        start_line - 1,
        false
      )[1]
      if prev_line and prev_line:match(is_comment_pattern) then
        start_line = start_line - 1
      else
        break
      end
    end

    -- Find end of contiguous comment block by scanning downwards
    local end_line = lnum
    local line_count = vim.api.nvim_buf_line_count(buf)
    while end_line < line_count do
      local next_line =
        vim.api.nvim_buf_get_lines(buf, end_line, end_line + 1, false)[1]
      if next_line and next_line:match(is_comment_pattern) then
        end_line = end_line + 1
      else
        break
      end
    end

    process_range(start_line, end_line)
  end,
})
