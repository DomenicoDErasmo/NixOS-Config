-- ==========================================
-- Plugins
-- ==========================================
 vim.pack.add {
    -- LSP config
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    -- required by none-ls
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvimtools/none-ls.nvim' },
    -- autocomplete
    { src = 'https://github.com/hrsh7th/nvim-cmp' },
    { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
    { src = 'https://github.com/hrsh7th/cmp-buffer' },
    { src = 'https://github.com/hrsh7th/cmp-path' },
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
-- LSP Commands
-- ==========================================

-- Only set mappings when LSP attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local buf = args.buf
        local opts = { buffer = buf, remap = false }

        -- Go to definition
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        -- Hover documentation
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        -- References
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        -- Type definition
        vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
        -- Rename symbol
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        -- Signature help (in insert mode)
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
    end,
})

-- ==========================================
-- Completion
-- ==========================================

local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
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
