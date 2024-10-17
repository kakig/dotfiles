-- disable old vim built in plugins to improve stability and performance
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

-- set <Leader> as <Space>
-- has to be done BEFORE loading plugins and setting other <Leader> bindings
vim.api.nvim_set_keymap('n', '<Space>', '<nop>', {})
vim.api.nvim_set_keymap('v', '<Space>', '<nop>', {})
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- disable guicursor
vim.o.guicursor = ''

-- enable 24-bit rgb (truecolor) support when running in terminals
vim.cmd('set termguicolors')

-- load plugins and configurations
require('cfg.plugins')
pcall(require, 'cfg.nvim-lspconfig')
pcall(require, 'cfg.nvim-treesitter')
pcall(require, 'cfg.gitsigns')
pcall(require, 'cfg.misc')
pcall(require, 'cfg.nvim-cmp')
pcall(require, 'cfg.dap')
pcall(require, 'cfg.aucmds')
pcall(require, 'cfg.custom_keybindings')
pcall(require, 'cfg.custom_opts')
pcall(require, 'cfg.watch')

-- load local lua init for overriding configs
if (vim.fn.filereadable('.nvim/init.lua') ~= 0) then
  vim.cmd('luafile .nvim/init.lua')
end
-- linit = vim.api.nvim_create_augroup("LocalInitLua", {})
-- vim.api.nvim_create_autocmd({"DirChanged"}, {group = linit, pattern = "global", command = "lua if (vim.fn.filereadable('./init.lua')) then pcall(require, 'init') end", once = false})
-- vim.api.nvim_create_autocmd({"DirChanged"}, {group = linit, pattern = "tabpage", command = "lua if (vim.fn.filereadable('./init.lua')) then pcall(require, 'init') end", once = false})
-- vim.api.nvim_create_autocmd({"DirChanged"}, {group = linit, pattern = "window", command = "lua if (vim.fn.filereadable('./init.lua')) then pcall(require, 'init') end", once = false})

-- disable filetype indentation
vim.cmd('filetype indent off')
