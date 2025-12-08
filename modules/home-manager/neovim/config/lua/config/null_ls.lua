
local stylua_cmd = os.getenv("HOME") .. "/.nix-profile/bin/stylua"

local null_ls = require("null-ls")

null_ls.setup({
	-- Lua formatting
	sources = {
		null_ls.builtins.formatting.stylua.with({
			command = stylua_cmd,
		}),
	},
})

-- Optional: create :Format command
vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format({ async = true })
end, {})