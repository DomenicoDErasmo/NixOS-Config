vim.lsp.config["nixd"] = {
    cmd = { "nixd" },
    settings = {},
    on_attach = function(client, bufnr)
        -- Disable nixd formatting so that we can use Alejandra
        client.server_capabilities.documentFormattingProvider = false
    end,
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "nix",
  callback = function()
    vim.lsp.start(vim.lsp.config["nixd"])
  end,
})
