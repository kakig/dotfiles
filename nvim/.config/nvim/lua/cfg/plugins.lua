local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  'neovim/nvim-lspconfig',
  'onsails/lspkind.nvim',
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'nvim-treesitter/playground',
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',
  'nvim-telescope/telescope.nvim',

  'tpope/vim-repeat',
  {
    'numToStr/Comment.nvim',
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    opts = {},
  },
  'ThePrimeagen/harpoon',

  'rebelot/kanagawa.nvim',
  { dir = '~/.dotfiles/private/dracula-pro-vim' },
  { dir = '~/personal/nvim-test-plugin' },
  'hoob3rt/lualine.nvim',
  'kyazdani42/nvim-web-devicons',
  'kyazdani42/nvim-tree.lua',
  'lewis6991/gitsigns.nvim',

  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
  'theHamsta/nvim-dap-virtual-text',
  'nvim-telescope/telescope-dap.nvim',

  {
    'tpope/vim-fugitive',
    opt = true,
    cmd = {
      'G',
      'Git',
      'Ggrep',
      'Gclog',
      'Gllog',
      'Gcd',
      'Glcd',
      'Gedit',
      'Gsplit',
      'Gvsplit',
      'Gtabedit',
      'Gpedit',
      'Gdrop',
      'Gread',
      'Gwrite',
      'Gwq',
      'Gdiffsplit',
      'GMove',
      'GRename',
      'GDelete',
      'GRemove',
      'GUnlink',
      'GBrowse',
    }
  },

  'vim-scripts/loremipsum',
  {'tweekmonster/startuptime.vim', opt = true, cmd = {'StartupTime'}},
  {
    'wwcd/nvim-ack',
    config = function()
      require('nvim-ack').setup()
      vim.keymap.set('n', '<Leader>sg', ':Ack ')
    end
  },
  {
    'monkoose/matchparen.nvim',
    opts = {},
  },
  {
    'Shatur/neovim-session-manager',
    config = function()
      local config = require('session_manager.config')
      require('session_manager').setup({
        autoload_mode = config.AutoloadMode.GitSession,
      })
    end
  },
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  {
    'stevearc/oil.nvim',
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { desc = "Open parent directory" })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  {
    'nmac427/guess-indent.nvim',
    opts = {},
  },
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  {
    'stevearc/stickybuf.nvim',
    opts = {},
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require('toggleterm').setup({
        open_mapping = "<F8>",
      })
      local trim_space = false
      vim.keymap.set("v", "<Leader><CR>", function()
        require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
      end)
    end
  },
}

require('lazy').setup(plugins)
