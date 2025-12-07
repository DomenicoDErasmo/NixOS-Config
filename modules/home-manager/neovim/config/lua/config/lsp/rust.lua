local rustfmt_cmd = os.getenv("HOME") .. "/.nix-profile/bin/rustfmt"

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