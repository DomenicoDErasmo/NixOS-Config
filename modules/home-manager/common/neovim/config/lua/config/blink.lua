local blink = require("blink.cmp")

blink.setup({
  keymap = {
    preset = "default",
    ["<C-d>"] = { "scroll_documentation_up" },
    ["<C-f>"] = { "scroll_documentation_down" },
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<C-Space>"] = { "show" },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  signature = {
    enabled = true,
  },
  completion = {
    documentation = {
      auto_show = true,
    },
  },
})

-- Set up LSP capabilities for blink.cmp
local capabilities = blink.get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })
