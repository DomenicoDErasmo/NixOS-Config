require("persistent-breakpoints").setup({
	save_dir = vim.fn.stdpath("data") .. "/dap-breakpoints",
	load_breakpoints_event = { "BufReadPost" },
	persistent_breakpoints_file = "breakpoints.json",
})
