vim.pack.add({
  -- LSP config
  { src = "https://github.com/neovim/nvim-lspconfig" },
  -- required by none-ls
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvimtools/none-ls.nvim" },
  -- telescope - customizable fuzzy finder
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  -- dev icons
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  -- git signs
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  -- status bar
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  -- TODO highlighting
  { src = "https://github.com/folke/todo-comments.nvim" },
  -- Markdown rendering
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  -- Obsidian support in Neovim
  { src = "https://github.com/obsidian-nvim/obsidian.nvim" },
  -- autocomplete
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  -- VSCode color scheme
  { src = "https://github.com/Mofiqul/vscode.nvim" },
  -- File Browser
  { src = "https://github.com/stevearc/oil.nvim" },
  -- Git status in file browser
  { src = "https://github.com/benomahony/oil-git.nvim" },
  -- Show LSP diagnoostic errors
  { src = "https://github.com/JezerM/oil-lsp-diagnostics.nvim" },
  -- Performance tool
  { src = "https://github.com/t-troebst/perfanno.nvim" },
  -- Rainbow delimiters
  { src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
  -- persistent terminals
  { src = "https://github.com/akinsho/toggleterm.nvim" },
  -- Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  -- Diff views
  { src = "https://github.com/sindrets/diffview.nvim" },
  -- Debugging
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
  { src = "https://github.com/nvim-telescope/telescope-dap.nvim" },
  { src = "https://github.com/Weissle/persistent-breakpoints.nvim" },
})
