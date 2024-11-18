(import-macros {:mixed-table ·} :toast.macros)
(local conjureft [:clojure
                  :fennel
                  :hy
                  :janet
                  :julia
                  :lisp
                  :racket
                  :scheme])

; simple stuff that doesn't need any handling
; and doesn't fit in elsewhere
[(· :folke/lazy.nvim & :version false)
 (· :Olical/nfnl     & :ft :fennel)
 (· :stevearc/dressing.nvim &
    :opts {})
 (· :Olical/conjure &
    :branch :main
    :config (fn [_ opts]
             (each [k v (pairs opts)]
              (tset vim.g (.. :conjure# k) v)))
    :opts {:mapping#prefix :<localleader>e
           :extract#tree_sitter#enabled true
           ; disabling lua, python, rust
           :filetypes conjureft
           :filetype#fennel :conjure.client.fennel.stdio
           :filetype#janet  :conjure.client.janet.stdio}
    :ft conjureft)
 [:tpope/vim-repeat]]
