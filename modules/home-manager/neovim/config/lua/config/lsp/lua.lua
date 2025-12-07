
local lua_ls_cmd = os.getenv("HOME") .. "/.nix-profile/bin/lua-language-server"

vim.lsp.config["lua_ls"] = {
	cmd = { lua_ls_cmd },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim", "require" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.lsp.start(vim.lsp.config["lua_ls"])
  end,
})