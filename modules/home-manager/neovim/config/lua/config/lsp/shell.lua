vim.lsp.config["shell"] = {
    cmd = { "bash-language-server", "--stdio" },
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "sh",
    callback = function()
        vim.lsp.start(vim.lsp.config["shell"])
    end,
})
