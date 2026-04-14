require("obsidian").setup({
  workspaces = {
    {
      name = "notes",
      path = "~/notes/",
    },
  },

  ui = { enable = false },
})

vim.o.conceallevel = 2
