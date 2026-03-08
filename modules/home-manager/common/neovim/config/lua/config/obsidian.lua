require("obsidian").setup({
  mappings = {
    -- Follow link
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },

    -- Hover preview of linked file
    ["K"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
  },

  workspaces = {
    {
      name = "notes",
      path = "~/notes/",
    },
  },

  ui = { enabled = false },
})

vim.o.conceallevel = 2
