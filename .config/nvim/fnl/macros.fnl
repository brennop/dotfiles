{:let!
 (fn [name value]
   `(tset vim.g ,name ,value))

 :set!
 (fn [name value]
   `(tset vim.opt ,name ,value))

 :cmd!
 (fn [cmd]
   `(vim.cmd ,cmd))}
