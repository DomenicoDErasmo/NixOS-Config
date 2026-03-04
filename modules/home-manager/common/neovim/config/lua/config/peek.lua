vim.keymap.set("n", "<leader>op", function()
  local line = vim.api.nvim_get_current_line()
  -- handles both [[wikilinks]] and [text](path)
  local path = line:match("%[%[(.-)%]%]") or line:match("%[.-%]%((.-)%)")
  if not path then
    vim.notify("No link found on this line", vim.log.levels.WARN)
    return
  end

  local client = require("obsidian").get_client()
  local note = client:resolve_note(path)
  if not note then
    vim.notify("Could not resolve note: " .. path, vim.log.levels.ERROR)
    return
  end

  -- Open in a floating window
  local lines = vim.fn.readfile(tostring(note.path))
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].filetype = "markdown"

  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.5)
  vim.api.nvim_open_win(buf, false, { -- false = don't focus the window
    relative = "cursor",
    width = width,
    height = height,
    col = 2,
    row = 1,
    style = "minimal",
    border = "rounded",
    title = " " .. path .. " ",
    title_pos = "center",
  })

  -- Auto-close when cursor moves
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
    once = true,
    callback = function()
      if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end,
  })
end, { desc = "Float preview linked note" })
