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
  { src = "https://github.com/epwalsh/obsidian.nvim" },
  -- Floating previews
  { src = "https://github.com/toppair/peek.nvim" },
})
