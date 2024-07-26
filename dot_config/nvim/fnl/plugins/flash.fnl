(import-macros {:mixed-table · : recc} :toast.macros)
[(· :folke/flash.nvim &
    :opts {:modes {:search {:enabled false}}}
    :event :VeryLazy
    :keys [(· :s #(recc :flash :jump) &
              :mode [:n :x :o]
              :desc :Flash)
           (· :S #(recc :flash :treesitter) &
              :mode [:n :x :o]
              :desc "Flash Treesitter")
           (· :r #(recc :flash :remote) &
              :mode :o
              :desc "Remote Flash")
           (· :R #(recc :flash :treesitter_search) &
              :mode [:o :x]
              :desc "Flash Treesitter Search")
           (· :<c-s> #(recc :flash :toggle) &
              :mode :c
              :desc "Toggle Flash Search")])]
