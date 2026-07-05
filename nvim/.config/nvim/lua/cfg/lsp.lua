-- TODO: move all servers to the mapping below
local servers = {  'gopls', 'clojure_lsp', 'jdtls', 'ts_ls', 'eslint' }

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

executable_cfg_mapping = {
  ['pyright-langserver'] = 'pyright',
  ['rust-analyzer'] = 'rust_analyzer',
  ['dart'] = 'dartls',
  ['arduino-language-server'] = 'arduino_language_server',
  ['clangd'] = 'clangd',
}

for exe_name, cfg_name in pairs(executable_cfg_mapping) do
  if vim.fn.executable(exe_name) == 1 then
    vim.lsp.enable(cfg_name)
  end
end

local arduino_cli_config = vim.fn.has('mac') == 1
  and vim.fn.expand('~/Library/Arduino15/arduino-cli.yaml')
  or vim.fn.expand('~/.arduino15/arduino-cli.yaml')

vim.lsp.config('arduino_language_server', {
  cmd = function(dispatchers, config)
    local root = config.root_dir or vim.fn.getcwd()
    local fqbn = 'arduino:avr:uno'
    local sketch_path = root .. '/sketch.yaml'
    if vim.fn.filereadable(sketch_path) == 1 then
      for line in io.lines(sketch_path) do
        local m = line:match('^%s*default_fqbn:%s*(%S+)')
        if m then fqbn = m; break end
      end
    end
    return vim.lsp.rpc.start(
      { 'arduino-language-server', '-cli-config', arduino_cli_config, '-fqbn', fqbn },
      dispatchers
    )
  end,
})
