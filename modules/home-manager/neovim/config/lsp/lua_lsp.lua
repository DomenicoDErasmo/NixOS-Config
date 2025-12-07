return {
    -- Command and arguments to start the server
    cmd = {'lua-language-server'}

    -- Filetypes to automatically attach to
    filetypes = {'lua'}

    -- Set the root directory to the parent directory of the file 
    -- in the current buffer that contains one of these nested files
    -- Files that share a root directory reuse the connection to the
    -- same LSP server
    -- Nested lists indicate equal priority
    root_markets = { 
        -- start with these two files
        {'.luarc.json', '.luarc.jsonc'}, 
        -- if not found, default to .git
        '.git'
    }

    -- Specific settings to send to the server
    -- The schema is defined by the server
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            }
        }
    }
}