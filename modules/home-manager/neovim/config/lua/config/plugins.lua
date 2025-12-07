vim.pack.add({
	-- LSP config
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	-- required by none-ls
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvimtools/none-ls.nvim" },
	-- autocomplete
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})