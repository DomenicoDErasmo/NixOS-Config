vim.lsp.config["pyright"] = {
    cmd = { "pyright-langserver" },
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
}
