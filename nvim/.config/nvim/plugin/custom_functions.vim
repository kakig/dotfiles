function! StripTrailingWhite()
  let l:winview = winsaveview()
  silent! %s/\s\+$//
  call winrestview(l:winview)
endfunction
nnoremap <Leader>sw <cmd>call StripTrailingWhite()<CR>
