local perfanno = require("perfanno")
local util = require("perfanno.util")

perfanno.setup({
	-- Creates a 10-step RGB color gradient beween background color and "#CC3300"
	line_highlights = util.make_bg_highlights(nil, "#CC3300", 10),
	vt_highlight = util.make_fg_highlight("#CC3300"),
})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>plf", ":PerfLoadFlat<CR>", opts)
vim.keymap.set("n", "<leader>plg", ":PerfLoadCallGraph<CR>", opts)
vim.keymap.set("n", "<leader>plo", ":PerfLoadFlameGraph<CR>", opts)

vim.keymap.set("n", "<leader>pe", ":PerfPickEvent<CR>", opts)

vim.keymap.set("n", "<leader>pa", ":PerfAnnotate<CR>", opts)
vim.keymap.set("n", "<leader>pf", ":PerfAnnotateFunction<CR>", opts)
vim.keymap.set("v", "<leader>pa", ":PerfAnnotateSelection<CR>", opts)

vim.keymap.set("n", "<leader>pt", ":PerfToggleAnnotations<CR>", opts)

vim.keymap.set("n", "<leader>ph", ":PerfHottestLines<CR>", opts)
vim.keymap.set("n", "<leader>ps", ":PerfHottestSymbols<CR>", opts)
vim.keymap.set("n", "<leader>pc", ":PerfHottestCallersFunction<CR>", opts)
vim.keymap.set("v", "<leader>pc", ":PerfHottestCallersSelection<CR>", opts)
