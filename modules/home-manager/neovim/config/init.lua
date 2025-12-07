-- ==========================================
-- Plugins
-- ==========================================
vim.pack.add {
    -- LSP config
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    -- required by none-ls
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvimtools/none-ls.nvim' },
}

-- ==========================================
-- Paths to Nix-installed binaries
-- ==========================================
local lspconfig = require("lspconfig")
local lua_ls_cmd = os.getenv("HOME") .. "/.nix-profile/bin/lua-language-server"
local stylua_cmd = os.getenv("HOME") .. "/.nix-profile/bin/stylua"

-- ==========================================
-- LSP Configuration
-- ==========================================

-- deprecated version seems to work
lspconfig.lua_ls.setup({
    cmd = { lua_ls_cmd },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim", "require" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
})

-- ==========================================
-- Formatter using null-ls
-- ==========================================
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua.with({
            command = stylua_cmd,  -- Use Nix-installed stylua
        }),
    },
})

-- Optional: create :Format command
vim.api.nvim_create_user_command('Format', function()
    vim.lsp.buf.format({ async = true })
end, {})
