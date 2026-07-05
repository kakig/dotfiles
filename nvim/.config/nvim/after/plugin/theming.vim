set cursorline
try
  colorscheme dracula_pro
catch /^Vim\%((\a\+)\)\=:E185/
  try
    colorscheme kanagawa-lotus
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme industry
  endtry
endtry

hi CursorLine guibg=#2b2a37

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
