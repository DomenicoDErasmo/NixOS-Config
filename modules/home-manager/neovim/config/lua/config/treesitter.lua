require("nvim-treesitter.config").setup({
	ensure_installed = { "lua", "rust", "cpp", "python", "css", "cmake", "markdown", "nix", "bash" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})
