local function with_desc(opts, extra)
  return vim.tbl_extend("force", opts, { desc = extra })
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    local opts = { buffer = buf, remap = false }

    -- Go to definition
    -- Related, jump lists:
    -- Ctrl+o to jump back and Ctrl-i to jump forward
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, with_desc(opts, "Go-to definition"))
    -- Hover documentation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, with_desc(opts, "Hover documentation"))
    -- References
    vim.keymap.set("n", "gr", vim.lsp.buf.references, with_desc(opts, "View references"))
    -- Type definition
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, with_desc(opts, "View type definition"))
    -- Rename symbol
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, with_desc(opts, "Rename symbol"))
    -- Signature help (in insert mode)
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, with_desc(opts, "Signature help"))
    -- Apply code fix (if available)
    vim.keymap.set("n", "gf", function()
      local diagnostics = vim.diagnostic.get(0)
      vim.lsp.buf.code_action({
        apply = true,
        context = { only = { "quickfix", "source.fixAll" }, diagnostics = diagnostics },
      })
    end, with_desc(opts, "Apply code fix (if available"))
  end,
})

-- Show diagnostic in a floating window
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show LSP Diagnostic" })

-- Jump to next/previous diagnostic
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous Diagnostic" })

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>", opts)

-- Extract path from markdown link [text](path) or plain path under cursor
vim.keymap.set("n", "<leader>fp", function()
  local line = vim.api.nvim_get_current_line()

  -- Try to find a markdown link [.*](path) near the cursor
  local path = nil
  for link_path in line:gmatch("%[.-%]%((.-)%)") do
    path = link_path
    break
  end

  -- Fallback to word under cursor
  if not path then
    path = vim.fn.expand("<cfile>")
  end

  -- Resolve relative to the current file's directory (not cwd)
  if not path:match("^/") then
    local current_dir = vim.fn.expand("%:p:h")
    path = current_dir .. "/" .. path
  end

  -- Normalize the path (resolves ../ and duplicate segments)
  path = vim.fn.simplify(path)

  if vim.fn.filereadable(path) == 0 then
    vim.notify("Cannot read file: " .. path, vim.log.levels.ERROR)
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local lines = vim.fn.readfile(path)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Set filetype for syntax highlighting
  local ext = path:match("%.(%w+)$")
  if ext then
    vim.bo[buf].filetype = ext
  end

  local width = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines * 0.7)
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded",
  })

  -- Close the float with q
  vim.keymap.set(
    "n",
    "q",
    "<cmd>close<CR>",
    { buffer = buf, silent = true, desc = "Extract preview from markdown link" }
  )
end, { desc = "Open preview of link" })

-- Open Neogit UI
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit UI" })

-- Close tab
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })

-- Apply fix if available
vim.keymap.set(
  "n",
  "<leader>ca",
  vim.lsp.buf.code_action,
  { noremap = true, silent = true, desc = "LSP: Code Action / Apply Fix" }
)
