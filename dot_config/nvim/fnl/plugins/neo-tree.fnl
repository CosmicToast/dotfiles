(import-macros {:mixed-table · : recc} :toast.macros)
[(· :nvim-neo-tree/neo-tree.nvim &
    :cmd :Neotree
    :dependencies [:nvim-lua/plenary.nvim
                   :MunifTanjim/nui.nvim]
    :keys [(· :<leader>n #(recc :neo-tree.command :execute {:toggle true}) &
              :desc :Neotree)]
    :opts {})]
