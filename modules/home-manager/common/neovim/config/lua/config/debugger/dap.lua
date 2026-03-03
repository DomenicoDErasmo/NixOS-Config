local dap = require("dap")

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

dap.adapters.lldb = {
  type = "executable",
  command = "lldb-dap",
  name = "lldb",
}

dap.configurations.cpp = {
  {
    name = "Launch file (LLDB)",
    type = "lldb", -- matches adapter name
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    args = {}, -- optional, e.g., GoogleTest filters
  },
}

dap.configurations.c = dap.configurations.cpp

-- Helper: pick executable from ./bin
local function pick_executable()
  local cwd = vim.fn.getcwd()
  local bin_dir = cwd .. "/bin"
  local files = vim.fn.globpath(bin_dir, "*", 0, 1)
  local exes = {}
  for _, f in ipairs(files) do
    if vim.fn.executable(f) == 1 then
      table.insert(exes, f)
    end
  end

  pickers
      .new({}, {
        prompt_title = "Select executable",
        finder = finders.new_table({ results = exes }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(bufnr)
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry().value
            actions.close(bufnr)

            -- Launch DAP with the selected binary
            dap.run({
              type = "lldb",
              name = "Launch " .. selection,
              request = "launch",
              program = selection,
              cwd = cwd,
              stopAtEntry = true,
            })
          end)
          return true
        end,
      })
      :find()
end

-- Map a key to pick + launch executable
vim.keymap.set("n", "<Leader>db", pick_executable, { noremap = true, silent = true })
