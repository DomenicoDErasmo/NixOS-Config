---@diagnostic disable-next-line
require("nvim-treesitter.config").setup({
  ensure_installed = {
    "bash",
    "cmake",
    "cpp",
    "css",
    "html",
    "lua",
    "markdown",
    "nix",
    "python",
    "rust",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
})

-- Enable Tree-sitter highlighting for all buffers (required in v1+)
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})
