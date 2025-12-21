vim.lsp.config["markdown"] = {
    cmd = { "marksman" },
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.lsp.start(vim.lsp.config["markdown"])
    end,
})
