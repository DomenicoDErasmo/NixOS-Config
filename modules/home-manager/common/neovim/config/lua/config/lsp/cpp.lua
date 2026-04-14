vim.lsp.config["cpp"] = {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--compile-commands-dir=" .. vim.fn.getcwd(),
		"--completion-style=detailed",
	},
	-- NOTE: capabilities set globally in blink.lua
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		vim.lsp.start(vim.lsp.config["cpp"])
	end,
})

vim.api.nvim_set_hl(0, "@lsp.type.operator.cpp", { link = "@keyword" })
