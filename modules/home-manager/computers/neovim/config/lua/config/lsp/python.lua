vim.lsp.config["pyright"] = {
	cmd = { "pyright-langserver", "--stdio" },
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.lsp.start(vim.lsp.config["pyright"])
	end,
})
