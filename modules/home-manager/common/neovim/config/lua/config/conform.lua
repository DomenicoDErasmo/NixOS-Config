local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    nix = { "alejandra" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    markdown = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters = {
    black = {
      prepend_args = { "--fast" },
    },
    prettier = {
      prepend_args = { "--prose-wrap", "always", "--print-width", "80" },
    },
  },
})

vim.api.nvim_create_user_command("Format", function()
  conform.format({ async = true, lsp_fallback = true })
end, {})
