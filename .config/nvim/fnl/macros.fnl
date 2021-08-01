{:let!
 (fn [name value]
   `(tset vim.g ,name ,value))

 :set!
 (fn [name value]
   `(tset vim.opt ,name ,value))

 :cmd!
 (fn [cmd]
   `(vim.cmd ,cmd))

 ;; Create an augroup for your autocmds.
 ;; author: Olical
 :augroup
 (fn [name ...]
   `(do
      (vim.cmd (.. "augroup " ,(tostring name) "\nautocmd!"))
      ,...
      (vim.cmd "augroup END")
      nil))}
