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
 (· :folke/snacks.nvim &
    :priority 1000 :lazy false
    :opts {:indent    {:enabled true
                       :scope   {:enabled false}}
           :input     {:enabled true}
           :quickfile {:enabled true}})
 (· :Olical/nfnl     & :ft :fennel)
 (· :Olical/conjure &
    :branch :main
    :config (fn [_ opts]
             (each [k v (pairs opts)]
              (tset vim.g (.. :conjure# k) v)))
    :opts {:mapping#prefix :<localleader>e
           :extract#tree_sitter#enabled true
           ; disabling lua, python, rust
           :filetypes conjureft
           :filetype#janet  :conjure.client.janet.stdio}
    :ft conjureft)
 [:tpope/vim-repeat]]
