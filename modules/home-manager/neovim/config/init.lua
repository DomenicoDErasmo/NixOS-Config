require("config.globals")
require("config.plugins")
require("config.colorscheme")
require("config.treesitter")
require("config.keymap")


-- ==========================================
-- Paths to Nix-installed binaries
-- ==========================================
local lspconfig = require("lspconfig")
local lua_ls_cmd = os.getenv("HOME") .. "/.nix-profile/bin/lua-language-server"
local stylua_cmd = os.getenv("HOME") .. "/.nix-profile/bin/stylua"
local rustfmt_cmd = os.getenv("HOME") .. "/.nix-profile/bin/rustfmt"

-- ==========================================
-- Lua LSP Configuration
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
-- Rust LSP Configuration
-- ==========================================
lspconfig.rust_analyzer.setup({
	cmd = { vim.fn.exepath("rust-analyzer") },
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = true,
		},
	},
	on_attach = on_attach,
})

-- ==========================================
-- Completion
-- ==========================================

local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	},
	mapping = {
		-- Scroll documentation popup
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		-- Confirm selection
		["<CR>"] = cmp.mapping.confirm({ select = true }),

		-- Tab for navigating
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),

		-- Shift-tab for previous selection
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	},
})

-- ==========================================
-- Formatter using null-ls
-- ==========================================
local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua.with({
			command = stylua_cmd,
		}),
	},
})

-- Optional: create :Format command
vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format({ async = true })
end, {})
