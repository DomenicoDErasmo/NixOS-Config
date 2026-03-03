vim.lsp.config["shell"] = {
    cmd = { "bash-language-server", "start", "--stdio" },
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sh", "bash", "zsh" },
    callback = function()
        vim.lsp.start(vim.lsp.config["shell"])
    end,
})
