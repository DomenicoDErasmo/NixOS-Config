local lint = require("lint")

lint.linters_by_ft = {
  python = { "pylint", "mypy" },
  markdown = { "markdownlint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
  callback = function()
    lint.try_lint()
  end,
})
