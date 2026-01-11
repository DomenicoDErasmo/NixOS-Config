vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

local ok, treesitter = pcall(require, "nvim-treesitter.config")
if not ok then
  treesitter = require("nvim-treesitter.configs")
end

treesitter.setup({
  ensure_installed = { "lua", "rust", "cpp", "python", "css", "cmake", "markdown", "nix", "bash" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})
