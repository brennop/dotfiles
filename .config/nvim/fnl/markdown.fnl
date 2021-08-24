(module markdown
  {autoload {a aniseed.core}
   require-macros [macros]})

;; set conceal
(cmd! "autocmd BufRead,BufNewFile *.md set conceallevel=2")

;; go to file 
; (map! :n "<CR>" ":e %:p:h/<cfile>.md<CR>")
