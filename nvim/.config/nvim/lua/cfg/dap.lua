local dap, dapui = require('dap'), require('dapui')

vim.g.dap_executable = nil

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch lldb-vscode',
    type = 'lldb',
    request = 'launch',
    program = function()
      if not vim.g.dap_executable then
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      else
        return vim.g.dap_executable
      end
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

vim.api.nvim_set_keymap("n", "<F9>", "<Cmd>lua require('dap').continue()<CR>", {})
vim.api.nvim_set_keymap("n", "<F10>", "<Cmd>lua require('dap').step_over()<CR>", {})
vim.api.nvim_set_keymap("n", "<F11>", "<Cmd>lua require('dap').step_into()<CR>", {})
vim.api.nvim_set_keymap("n", "<F12>", "<Cmd>lua require('dap').step_out()<CR>", {})

-- vim.api.nvim_set_keymap("n", "<Leader>xhh", "<Cmd>lua require('dap.ui.variables').hover()<CR>", {})
-- vim.api.nvim_set_keymap("v", "<Leader>xhv", "<Cmd>lua require('dap.ui.variables').visual_hover()<CR>", {})

vim.api.nvim_set_keymap("n", "<Leader>xuh", "<Cmd>lua require('dap.ui.widgets').hover()<CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>xuf", "<Cmd>lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", {})

vim.api.nvim_set_keymap("n", "<C-s>", "<Cmd>lua require('dapui').eval()<CR>", {})

vim.api.nvim_set_keymap("n", "<Leader>xro", "<Cmd>lua require('dap').repl.open()<CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>xrl", "<Cmd>lua require('dap').repl.run_last()<CR>", {})

vim.api.nvim_set_keymap("n", "<Leader>xbc", "<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>xbm", "<Cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>xbt", "<Cmd>lua require('dap').toggle_breakpoint()<CR>", {})

vim.api.nvim_set_keymap("n", "<Leader>xc", "<Cmd>lua require('dap.ui.variables').scopes()<CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>xi", "<Cmd>lua require('dapui').toggle()<CR>", {})

require('dapui').setup()
require("nvim-dap-virtual-text").setup {
    enabled = true,                        -- enable this plugin (the default)
    enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,               -- show stop reason when stopped for exceptions
    commented = false,                     -- prefix virtual text with comment string
    only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
    all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
    filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
    -- experimental features:
    virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
                                           -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}


-- dap.listeners.after.event_initialized['dapui_config'] = function()
--   dapui.open()
-- end
-- dap.listeners.after.event_terminated['dapui_config'] = function()
--   dapui.close()
-- end
-- dap.listeners.after.event_exited['dapui_config'] = function()
--   dapui.close()
-- end
