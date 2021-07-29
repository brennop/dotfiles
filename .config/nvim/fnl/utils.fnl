(module utils)

(def- opts { :noremap true :silent true })

(defn map [mode lhs rhs]
  (vim.api.nvim_set_keymap mode lhs rhs opts))

(defn noremap! [lhs rhs] 
  (vim.api.nvim_set_keymap
    :n
    (.. "<leader>" lhs)
    (.. ":" rhs "<CR>")
    opts))

