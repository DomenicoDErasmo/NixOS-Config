local stylua_cmd = os.getenv("HOME") .. "/.nix-profile/bin/stylua"

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- Lua
        null_ls.builtins.formatting.stylua.with({
            command = stylua_cmd,
        }),

        -- Python
        null_ls.builtins.formatting.black.with({
            extra_args = { "--fast" }, -- optional, speeds up formatting
            filetypes = { "python" },
        }),
        null_ls.builtins.diagnostics.pylint.with({
            filetypes = { "python" },
        }),
        null_ls.builtins.diagnostics.mypy.with({ filetypes = { "python" } }),

        -- Nix
        null_ls.builtins.formatting.alejandra.with({
            filetypes = { "nix" },
        }),

        -- C++
        null_ls.builtins.formatting.clang_format,

        -- Markdown
        null_ls.builtins.formatting.markdownlint,
    },

    on_attach = function(client, bufnr)
        if client:supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})

-- Optional: create :Format command
vim.api.nvim_create_user_command("Format", function()
    vim.lsp.buf.format({ async = true })
end, {})
