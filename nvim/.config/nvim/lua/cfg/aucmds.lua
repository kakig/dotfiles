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

-- disable automatic indentation everywhere
disable_indent = vim.api.nvim_create_augroup("DisableIndent", {})
vim.api.nvim_create_autocmd({"Filetype"}, {group = disable_indent, pattern = "*", command = "setlocal indentexpr=", once = false})
vim.api.nvim_create_autocmd({"Filetype"}, {group = disable_indent, pattern = "*", command = "setlocal nosmartindent", once = false})
vim.api.nvim_create_autocmd({"Filetype"}, {group = disable_indent, pattern = "*", command = "setlocal nocindent", once = false})
vim.api.nvim_create_autocmd({"BufEnter"}, {group = disable_indent, pattern = "*", command = "setlocal formatoptions-=cro", once = false})
