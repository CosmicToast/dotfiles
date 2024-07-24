(import-macros {: tbl : recc} :toast.macros)
[(tbl :nvim-neo-tree/neo-tree.nvim &
      :cmd :Neotree
      :dependencies [:nvim-lua/plenary.nvim
                     :MunifTanjim/nui.nvim]
      :keys [(tbl :<leader>n #(recc :neo-tree.command :execute {:toggle true}) &
                  :desc :Neotree)]
      :opts {})]
