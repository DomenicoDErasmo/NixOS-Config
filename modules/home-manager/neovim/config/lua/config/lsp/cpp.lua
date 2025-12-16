vim.lsp.config["cpp"] = {
	cmd = { "clangd", "--query-driver=/nix/store/*-clang-wrapper-*/bin/clang++" },
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		vim.lsp.start(vim.lsp.config["cpp"])
	end,
})
