vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.md" },
  callback = function()
    vim.opt_local.wrap = true    -- Enable visual line wrapping
    vim.opt_local.linebreak = true -- Wrap at word boundaries rather than characters
    vim.opt_local.textwidth = 0  -- Disable hard wrapping (no automatic newline characters added)
    vim.opt_local.wrapmargin = 0 -- Ensure no wrap margin is set
    -- Optional: Set the screen to behave as if it has a specific width for visual wrapping
    -- vim.opt_local.columns = 80    -- This affects vertical splits, use with caution
  end,
})
