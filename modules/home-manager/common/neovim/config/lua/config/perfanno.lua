local perfanno = require("perfanno")
local util = require("perfanno.util")

perfanno.setup({
  -- Creates a 10-step RGB color gradient beween background color and "#CC3300"
  line_highlights = util.make_bg_highlights(nil, "#CC3300", 10),
  vt_highlight = util.make_fg_highlight("#CC3300"),
})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<LEADER>plf", ":PerfLoadFlat<CR>", opts)
vim.keymap.set("n", "<LEADER>plg", ":PerfLoadCallGraph<CR>", opts)
vim.keymap.set("n", "<LEADER>plo", ":PerfLoadFlameGraph<CR>", opts)

vim.keymap.set("n", "<LEADER>pe", ":PerfPickEvent<CR>", opts)

vim.keymap.set("n", "<LEADER>pa", ":PerfAnnotate<CR>", opts)
vim.keymap.set("n", "<LEADER>pf", ":PerfAnnotateFunction<CR>", opts)
vim.keymap.set("v", "<LEADER>pa", ":PerfAnnotateSelection<CR>", opts)

vim.keymap.set("n", "<LEADER>pt", ":PerfToggleAnnotations<CR>", opts)

vim.keymap.set("n", "<LEADER>ph", ":PerfHottestLines<CR>", opts)
vim.keymap.set("n", "<LEADER>ps", ":PerfHottestSymbols<CR>", opts)
vim.keymap.set("n", "<LEADER>pc", ":PerfHottestCallersFunction<CR>", opts)
vim.keymap.set("v", "<LEADER>pc", ":PerfHottestCallersSelection<CR>", opts)
