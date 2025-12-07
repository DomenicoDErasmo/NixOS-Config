require("config.globals")
require("config.plugins")
require("config.cmp")
require("config.colorscheme")
require("config.treesitter")
require("config.keymap")
require("config.lsp.lua")


-- ==========================================
-- Paths to Nix-installed binaries
-- ==========================================
local stylua_cmd = os.getenv("HOME") .. "/.nix-profile/bin/stylua"
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
            rustfmt = { overrideCommand = { "rustfmt" } }
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
