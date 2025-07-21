set cursorline
try
  colorscheme dracula_pro_alucard
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme kanagawa-lotus
endtry

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
