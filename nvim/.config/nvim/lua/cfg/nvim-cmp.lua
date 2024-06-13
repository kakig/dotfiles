-- Setup nvim-cmp.
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

vim.o.completeopt = 'menuone,noinsert,noselect'

cmp.setup({
  preselect = cmp.PreselectMode.None,
  experimental = {
    ghost_text = false
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    --completion = cmp.config.window.bordered(),
    --documentation = cmp.config.window.bordered(),
  },
  performance = {
  --   debounce = 10,
  --   throttle = 10,
    -- fetching_timeout = 500,
  },
  mapping = cmp.mapping.preset.insert({
    ['<M-b>'] = cmp.mapping.scroll_docs(-4),
    ['<M-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-f>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-j>'] = cmp.mapping(function(fallback)
      luasnip.expand_or_jump()
    end),
    ['<C-k>'] = cmp.mapping(function(fallback)
      luasnip.jump(-1)
    end),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.config.disable,
  }),

  sources = cmp.config.sources({
    -- { name = 'luasnip' }, -- For luasnip users.
    { name = "copilot", group_index = 2 },
    {
      name = 'nvim_lsp',
      -- trigger_characters = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '_', '.', '/'},
      -- max_item_count = 10000,
    },
    { name = 'buffer' },
    {
      name = 'nvim_lsp_signature_help'
    },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
      { name = 'cmdline' }
    })
})

-- load custom snippets
require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config') .. '/snippets-lua' })
