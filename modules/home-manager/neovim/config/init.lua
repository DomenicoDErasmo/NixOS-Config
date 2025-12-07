require("config.globals")
require("config.plugins")
require("config.cmp")
require("config.colorscheme")
require("config.treesitter")
require("config.keymap")
require("config.null_ls")
require("config.lsp.lua")

-- ==========================================
-- Paths to Nix-installed binaries
-- ==========================================
local rustfmt_cmd = os.getenv("HOME") .. "/.nix-profile/bin/rustfmt"

-- ==========================================
-- Rust LSP Configuration
-- ==========================================
vim.lsp.config["rust_analyzer"] = {
	cmd = { vim.fn.exepath("rust-analyzer") },
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = true,
			rustfmt = { overrideCommand = { "rustfmt" } },
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
