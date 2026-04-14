vim.pack.add({
	-- LSP config
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	-- required by various plugins
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	-- Linting
	{ src = "https://github.com/mfussenegger/nvim-lint" },
	-- Formatting
	{ src = "https://github.com/stevearc/conform.nvim" },
	-- telescope - customizable fuzzy finder
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	-- NOTE: telescope-fzf-native managed by Nix (pre-compiled)
	-- dev icons
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	-- git signs
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	-- status bar
	{ src = "https://github.com/nvim-lualine/lualine.nvim", deps = { "nvim-tree/nvim-web-devicons" } },
	-- TODO highlighting
	{ src = "https://github.com/folke/todo-comments.nvim", deps = { "plenary.nvim" } },
	-- Markdown rendering
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	-- Obsidian support in Neovim
	{ src = "https://github.com/obsidian-nvim/obsidian.nvim" },
	-- NOTE: blink.cmp managed by Nix (pre-compiled)
	-- VSCode color scheme
	{ src = "https://github.com/Mofiqul/vscode.nvim" },
	-- File Browser
	{ src = "https://github.com/stevearc/oil.nvim" },
	-- Git status in file browser
	{ src = "https://github.com/benomahony/oil-git.nvim", deps = { "stevearc/oil.nvim" } },
	-- Show LSP diagnostic errors
	{ src = "https://github.com/JezerM/oil-lsp-diagnostics.nvim", deps = { "stevearc/oil.nvim" } },
	-- Performance tool
	{ src = "https://github.com/t-troebst/perfanno.nvim", deps = { "nvim-telescope/telescope.nvim" } },
	-- Rainbow delimiters
	{ src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
	-- persistent terminals
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	-- NOTE: nvim-treesitter managed by Nix (with parsers)
	-- Diff views
	{ src = "https://github.com/sindrets/diffview.nvim" },
	-- Debugging
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui", deps = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
	{ src = "https://github.com/nvim-telescope/telescope-dap.nvim" },
	{ src = "https://github.com/Weissle/persistent-breakpoints.nvim" },
	-- Git UI
	{ src = "https://github.com/NeogitOrg/neogit" },
	-- Show available keybinds
	{ src = "https://github.com/folke/which-key.nvim" },
	-- Indenting guides
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	-- Highlight other uses of the word under the cursor
	{ src = "https://github.com/RRethy/vim-illuminate" },
	-- Autopairs
	{ src = "https://github.com/windwp/nvim-autopairs" },
})
