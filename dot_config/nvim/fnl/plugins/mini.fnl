(import-macros {:mixed-table · : recc} :toast.macros)
[(· :echasnovski/mini.nvim &
    :version false
    :config (fn [_ opts]
             (each [k v (pairs opts)]
              (recc (.. :mini. k) :setup v)))
    :opts {:ai {}
           :align {}
           :basics {}
           :bracketed {:indent {:options {:change_type :diff}}}
           :comment {}
           :completion {}
           :cursorword {}
           :indentscope {}
           :move {}
           :splitjoin {}
           :statusline {}
           :tabline {}
           :trailspace {}})]
