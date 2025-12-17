vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local buf = args.buf
        local opts = { buffer = buf, remap = false }

        -- Go to definition
        -- Related, jump lists:
        -- Ctrl+o to jump back and Ctrl-i to jump forward
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        -- Hover documentation
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        -- References
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        -- Type definition
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
        -- Rename symbol
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        -- Signature help (in insert mode)
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
    end,
})

-- Show diagnostic in a floating window
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show LSP Diagnostic" })

-- Jump to next/previous diagnostic
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })

-- Create a fold keymap group
local opts = { noremap = true, silent = true }

-- Toggle fold under cursor
vim.api.nvim_set_keymap("n", "<leader>z", "za", opts)

-- Open fold under cursor
vim.api.nvim_set_keymap("n", "<leader>o", "zo", opts)

-- Close fold under cursor
vim.api.nvim_set_keymap("n", "<leader>c", "zc", opts)

-- Open all folds in buffer
vim.api.nvim_set_keymap("n", "<leader>O", "zR", opts)

-- Close all folds in buffer
vim.api.nvim_set_keymap("n", "<leader>C", "zM", opts)
