(import-macros {: tbl : recc} :toast.macros)
[(tbl :folke/flash.nvim &
      :opts {:modes {:search {:enabled false}}}
      :event :VeryLazy
      :keys [(tbl :s #(recc :flash :jump) &
              :mode [:n :x :o]
              :desc :Flash)
             (tbl :S #(recc :flash :treesitter) &
              :mode [:n :x :o]
              :desc "Flash Treesitter")
             (tbl :r #(recc :flash :remote) &
              :mode :o
              :desc "Remote Flash")
             (tbl :R #(recc :flash :treesitter_search) &
              :mode [:o :x]
              :desc "Flash Treesitter Search")
             (tbl :<c-s> #(recc :flash :toggle) &
              :mode :c
              :desc "Toggle Flash Search")])]
