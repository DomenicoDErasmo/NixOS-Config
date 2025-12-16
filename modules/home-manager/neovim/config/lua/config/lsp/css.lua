vim.lsp.config["css"] = {
    cmd = { "vscode-css-language-server", "--stdio" },
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "css",
    callback = function()
        vim.lsp.start(vim.lsp.config["css"])
    end,
})
