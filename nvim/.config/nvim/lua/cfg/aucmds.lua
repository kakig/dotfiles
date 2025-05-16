-- Highlight every yank (including the ones made in visual mode)
function highlight_on_yank()
  require('vim.hl').on_yank()
  return nil
end

luahl = vim.api.nvim_create_augroup("LuaHighlight", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = luahl,
  pattern = "*",
  callback = highlight_on_yank
})

-- clean cmdline messages autmatically
cleanmsg = vim.api.nvim_create_augroup("CleanMessages", {})
vim.api.nvim_create_autocmd({"CursorMoved"}, {group = cleanmsg, pattern = "*", command = "echo", once = false})

-- custom autocommands
custom_aucmds = vim.api.nvim_create_augroup("CustomAucmds", {})
vim.api.nvim_create_autocmd({"Filetype"}, {group = custom_aucmds, pattern = "*", command = "setlocal indentexpr=", once = false})
vim.api.nvim_create_autocmd({"Filetype"}, {group = custom_aucmds, pattern = "*", command = "setlocal nosmartindent", once = false})
vim.api.nvim_create_autocmd({"Filetype"}, {group = custom_aucmds, pattern = "*", command = "setlocal nocindent", once = false})
vim.api.nvim_create_autocmd({"BufEnter"}, {group = custom_aucmds, pattern = "*", command = "setlocal formatoptions-=cro", once = false})
