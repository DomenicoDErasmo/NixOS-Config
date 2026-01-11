local dap = require("dap")

-- Directory to store breakpoints
vim.fn.mkdir(vim.fn.stdpath("data") .. "/dap-breakpoints", "p")

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    require("dap.breakpoints").save(vim.fn.stdpath("data") .. "/dap-breakpoints")
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("dap.breakpoints").load(vim.fn.stdpath("data") .. "/dap-breakpoints")
  end,
})
