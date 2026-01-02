vim.lsp.config["cpp"] = {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--compile-commands-dir=" .. vim.loop.cwd(),
  },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.lsp.start(vim.lsp.config["cpp"])
  end,
})
