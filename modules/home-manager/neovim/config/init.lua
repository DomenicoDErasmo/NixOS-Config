require("config.globals")
require("config.plugins")
require("config.cmp")
require("config.colorscheme")
require("config.treesitter")
require("config.keymap")


-- ==========================================
-- Paths to Nix-installed binaries
-- ==========================================
local lua_ls_cmd = os.getenv("HOME") .. "/.nix-profile/bin/lua-language-server"
local stylua_cmd = os.getenv("HOME") .. "/.nix-profile/bin/stylua"
local rustfmt_cmd = os.getenv("HOME") .. "/.nix-profile/bin/rustfmt"

-- ==========================================
-- Lua LSP Configuration
-- ==========================================

vim.lsp.config["lua_ls"] = {
	cmd = { lua_ls_cmd },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim", "require" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.lsp.start(vim.lsp.config["lua_ls"])
  end,
})

-- ==========================================
-- Rust LSP Configuration
-- ==========================================
vim.lsp.config["rust_analyzer"] = {
	cmd = { vim.fn.exepath("rust-analyzer") },
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = true,
		},
	},
	on_attach = on_attach,
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rs",
  callback = function()
    vim.lsp.start(vim.lsp.config["rust_analyzer"])
  end,
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
