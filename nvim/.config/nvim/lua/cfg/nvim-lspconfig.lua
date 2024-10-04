local nvim_lsp = require('lspconfig')
local capabilities = vim.tbl_deep_extend(
"force", vim.lsp.protocol.make_client_capabilities(),
require('cmp_nvim_lsp').default_capabilities())

-- See https://github.com/neovim/neovim/issues/23291
-- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
-- capabilities.textDocument.documentSymbol = false

-- local navic = require('nvim-navic')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- i hope this works
  if client.name == "omnisharp" then
    client.server_capabilities.semanticTokensProvider = {
      full = vim.empty_dict(),
      legend = {
        tokenModifiers = { "static_symbol" },
        tokenTypes = {
          "comment",
          "excluded_code",
          "identifier",
          "keyword",
          "keyword_control",
          "number",
          "operator",
          "operator_overloaded",
          "preprocessor_keyword",
          "string",
          "whitespace",
          "text",
          "static_symbol",
          "preprocessor_text",
          "punctuation",
          "string_verbatim",
          "string_escape_character",
          "class_name",
          "delegate_name",
          "enum_name",
          "interface_name",
          "module_name",
          "struct_name",
          "type_parameter_name",
          "field_name",
          "enum_member_name",
          "constant_name",
          "local_name",
          "parameter_name",
          "method_name",
          "extension_method_name",
          "property_name",
          "event_name",
          "namespace_name",
          "label_name",
          "xml_doc_comment_attribute_name",
          "xml_doc_comment_attribute_quotes",
          "xml_doc_comment_attribute_value",
          "xml_doc_comment_cdata_section",
          "xml_doc_comment_comment",
          "xml_doc_comment_delimiter",
          "xml_doc_comment_entity_reference",
          "xml_doc_comment_name",
          "xml_doc_comment_processing_instruction",
          "xml_doc_comment_text",
          "xml_literal_attribute_name",
          "xml_literal_attribute_quotes",
          "xml_literal_attribute_value",
          "xml_literal_cdata_section",
          "xml_literal_comment",
          "xml_literal_delimiter",
          "xml_literal_embedded_expression",
          "xml_literal_entity_reference",
          "xml_literal_name",
          "xml_literal_processing_instruction",
          "xml_literal_text",
          "regex_comment",
          "regex_character_class",
          "regex_anchor",
          "regex_quantifier",
          "regex_grouping",
          "regex_alternation",
          "regex_text",
          "regex_self_escaped_character",
          "regex_other_escape",
        },
      },
      range = true,
    }
  end

  -- navic.attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>ln', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>cf', '<Cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= "tsserver" end})<CR>', opts)
  buf_set_keymap('n', '<Leader>cf', '<Cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
  buf_set_keymap('n', 'ga', '<Cmd>ClangdSwitchSourceHeader<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {  'solargraph', 'gopls', 'clojure_lsp', 'ts_ls', 'prismals', 'eslint', 'texlab', 'tailwindcss' }
local enabled_servers = {}
for _, server in ipairs(servers) do
  -- check if the actual executable (*NOT* the lspconfig server name) is
  -- present on the system before trying to configure it
  if vim.fn.executable(nvim_lsp[server]['document_config']['default_config']['cmd'][1]) == 1 then
    table.insert(enabled_servers, server)
  end
end
for _, lsp in ipairs(enabled_servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 50,
    }
  }
end

-- eslintfix = vim.api.nvim_create_augroup("EslintFix", {})
-- vim.api.nvim_create_autocmd({"BufWritePre"}, {group = eslintfix, pattern = {"*.tsx", "*.ts", "*.jsx", "*.js"}, command = "EslintFixAll"})

if vim.fn.executable('pyright-langserver') == 1 then
  nvim_lsp['pyright'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      pyright = {
        autoImportCompletion = true,
      },
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = 'openFilesOnly',
          useLibraryCodeForTypes = true,
          typeCheckingMode = 'off',
        }
      }
    }
  }
end

if vim.fn.executable('rust-analyzer') == 1 then
  nvim_lsp['rust_analyzer'].setup {
    -- cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 50,
    },
  }
end

if vim.fn.executable('clangd') == 1 then
  nvim_lsp['clangd'].setup { -- c++ servers just don't work properly
    cmd = {
      'clangd',
      '--fallback-style=Google',
      '--background-index',
      '--suggest-missing-includes',
      '--clang-tidy',
      '--header-insertion=iwyu',
    },
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 50,
    }
  }
end

if vim.fn.executable('omnisharp') == 1 then
  nvim_lsp['omnisharp'].setup {
    cmd = { 'omnisharp', '--languageserver', '--hostPID', tostring(pid) },
    capabilities = capabilities,
    on_attach = on_attach
  }
end

if vim.fn.executable('dart') == 1 then
  nvim_lsp['dartls'].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

local M = {}
M.on_attach = on_attach

return M
