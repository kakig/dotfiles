-- NvimTree
vim.api.nvim_set_keymap('n', '<Leader>n', '<Cmd>NvimTreeToggle<CR>', {noremap = true})
require('nvim-tree').setup {
  disable_netrw = false,
  hijack_netrw = false,
  renderer = {
    icons = {
      glyphs = {
        git = {
          unstaged = '!',
          staged = '+',
          untracked = '?'
        },
      },
    },
  },
  hijack_directories = {
    enable = false,
    auto_open = false,
  },
  view = {
    signcolumn = "no"
  },
  filters = {
    dotfiles = false,
  },
  update_focused_file = {
    enable = true,
  },
}

-- lualine.nvim
-- -- Copyright (c) 2020-2021 shadmansaleh
-- MIT license, see LICENSE for more details.
-- Credit itchyny, jackno (lightline)
local colors = {
  gray       = '#A5ACD9',
  lightgray  = '#E1E2E6',
  orange     = '#A86200',
  purple     = '#1C00A8',
  red        = '#A81C00',
  yellow     = '#A8A800',
  green      = '#0EA800',
  white      = '#282A36',
  black      = '#F8F8F2',
}

local dracula_light_lualine = {
  normal = {
    a = { bg = colors.purple, fg = colors.black, gui = 'bold' },
    b = { bg = colors.gray, fg = colors.white },
    c = { bg = colors.lightgray, fg = colors.white },
  },
  insert = {
    a = { bg = colors.green, fg = colors.black, gui = 'bold' },
    b = { bg = colors.gray, fg = colors.white },
    c = { bg = colors.lightgray, fg = colors.white },
  },
  visual = {
    a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
    b = { bg = colors.gray, fg = colors.white },
    c = { bg = colors.lightgray, fg = colors.white },
  },
  replace = {
    a = { bg = colors.red, fg = colors.black, gui = 'bold' },
    b = { bg = colors.gray, fg = colors.white },
    c = { bg = colors.lightgray, fg = colors.white },
  },
  command = {
    a = { bg = colors.orange, fg = colors.black, gui = 'bold' },
    b = { bg = colors.gray, fg = colors.white },
    c = { bg = colors.lightgray, fg = colors.white },
  },
  inactive = {
    a = { bg = colors.gray, fg = colors.white, gui = 'bold' },
    b = { bg = colors.gray, fg = colors.white },
    c = { bg = colors.lightgray, fg = colors.white },
  },
}

local function encoding()
  return string.upper(vim.o.fileencoding)
end

local function filetype()
  return vim.o.filetype
end

local function progress()
  local cur = vim.fn.line('.')
  local total = vim.fn.line('$')
  if cur == 1 then
    return 'TOP'
  elseif cur == total then
    return 'BOT'
  else
    return string.format('%2d%%%%', math.floor(cur / total * 100))
  end
end

local function location()
  local line = vim.fn.line('.')
  local col = vim.fn.virtcol('.')
  return string.format('%d:%-2d', line, col) .. ' ' .. progress()
end

require('lualine').setup {
  options = {
    theme = "dracula",
    section_separators = {},
    component_separators = { right = '|' }
  },
  sections = {
    lualine_b = {
      'filename',
    },
    lualine_c = {
      'branch',
      'diff',
      'diagnostics',
    },
    lualine_x = {
      location,
    },
    lualine_y = {
      encoding,
      {
        'fileformat',
        symbols = {
          unix = 'UNIX', -- e712
            dos = 'DOS',  -- e70f
            mac = 'MAC',  -- e711
        },
      },
      filetype,
    },
    lualine_z = {
      'filesize',
    },
  },
}

-- telescope
vim.api.nvim_set_keymap('n', '<Leader>ff', '<Cmd>lua require(\'telescope.builtin\').find_files()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>fg', '<Cmd>lua require(\'telescope.builtin\').live_grep()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>fb', '<Cmd>lua require(\'telescope.builtin\').buffers()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>f?', '<Cmd>lua require(\'telescope.builtin\').help_tags()<CR>', {noremap = true})

-- dirvish
vim.g.dirvish_mode = ':sort | sort ,^.*[^/]$, r'

-- fugitive
vim.api.nvim_set_keymap('n', '<Leader>G', ':silent! tab G<CR><C-l>', {noremap = true})

-- harpoon
vim.cmd [[
nnoremap <Leader>a :lua require('harpoon.mark').add_file()<CR>
nnoremap <C-e> :lua require('harpoon.ui').toggle_quick_menu()<CR>

nnoremap <F1> :lua require('harpoon.ui').nav_file(1)<CR>
nnoremap <F2> :lua require('harpoon.ui').nav_file(2)<CR>
nnoremap <F3> :lua require('harpoon.ui').nav_file(3)<CR>
nnoremap <F4> :lua require('harpoon.ui').nav_file(4)<CR>
]]
