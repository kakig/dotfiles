local bufnr = 4

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("experiment", { clear = true }),
  callback = function()
    vim.fn.jobstart({'ls', '-lahQv'}, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data)
        end
      end,
      on_stderr = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
        end
      end
    })
  end,
})
