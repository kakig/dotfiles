-- helper functions
local nnoremap = function(lhs, rhs)
  vim.api.nvim_set_keymap('n', lhs, rhs, {noremap = true})
end
local vnoremap = function(lhs, rhs)
  vim.api.nvim_set_keymap('v', lhs, rhs, {noremap = true})
end
local inoremap = function(lhs, rhs)
  vim.api.nvim_set_keymap('i', lhs, rhs, {noremap = true})
end

-- swap : and ;
nnoremap(':', ';')
nnoremap(';', ':')
vnoremap(':', ';')
vnoremap(';', ':')

-- navigate between windows using alt
nnoremap('<M-h>', '<C-w>h')
nnoremap('<M-j>', '<C-w>j')
nnoremap('<M-k>', '<C-w>k')
nnoremap('<M-l>', '<C-w>l')

-- make alt-enter behavior similar to other editors
inoremap('<M-CR>', '<Esc>o')

-- stolen from ThePrimeagen
vnoremap('<Leader>p', '"_dP')
nnoremap('<Leader>p', '"0p')
nnoremap('<Leader>P', '"0P')
nnoremap('<Leader>d', '"_d')
vnoremap('<Leader>d', '"_d')

-- yank to system clipboard
nnoremap('<Leader>y', '"+y')
vnoremap('<Leader>y', '"+y')
nnoremap('<Leader>Y', 'gg"+yG')

-- open file explorer in splits
nnoremap('<Leader>fe', '<Cmd>e %:p:h<CR>')
nnoremap('<Leader>fv', '<Cmd>vsp %:p:h<CR>')
nnoremap('<Leader>fh', '<Cmd>sp %:p:h<CR>')
nnoremap('<Leader>ft', '<Cmd>tabe %:p:h<CR>')

-- sort imports
nnoremap('<Leader>is', 'vip:sort<CR>')

-- toggle highlight search
vim.api.nvim_set_keymap('n', '<Leader>h', "(&hls && v:hlsearch ? '<cmd>set nohlsearch' : '<cmd>set hlsearch').\"\n\"", {noremap = true, silent = true, expr = true})

-- toggle colorcolumn on col 80
vim.api.nvim_set_keymap('n', '<Leader>8', '<Cmd>execute "setlocal colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>', {noremap = true, silent = true})
