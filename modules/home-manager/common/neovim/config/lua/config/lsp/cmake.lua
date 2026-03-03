vim.lsp.config["cmake"] = {
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    root_dir = vim.fs.root(0, {
        "CMakeLists.txt",
        ".git",
    }),
    init_options = {
        buildDirectory = "build",
    },
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cmake",
    callback = function()
        vim.lsp.start(vim.lsp.config["cmake"])
    end,
})
