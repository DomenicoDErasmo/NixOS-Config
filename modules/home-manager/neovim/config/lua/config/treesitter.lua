vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "rust" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    }
}