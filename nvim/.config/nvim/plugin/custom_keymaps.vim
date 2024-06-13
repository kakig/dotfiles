" toggle automatic text wrapping (for writing latex/markdown)
nnoremap <Leader>of <cmd>call AutoWrapToggle()<CR>
function! AutoWrapToggle()
  if &formatoptions =~ 'a'
    set fo-=a
  else
    set fo+=a
  endif
endfunction
