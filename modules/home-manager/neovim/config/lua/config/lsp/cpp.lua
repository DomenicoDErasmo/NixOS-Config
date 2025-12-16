vim.lsp.config["cpp"] = {
	cmd = { "clangd" },
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		vim.lsp.start(vim.lsp.confg["cpp"])
	end,
})
