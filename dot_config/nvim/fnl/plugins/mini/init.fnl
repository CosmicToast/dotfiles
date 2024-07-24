(import-macros {: tbl : recc} :toast.macros)
[(tbl :echasnovski/mini.nvim &
      :version false
      :config (fn [_ opts]
               (each [k v (pairs opts)]
                (recc (.. :mini. k) :setup v)))
      :opts (fn [] {:ai {}
                    :align {}
                    :basics {}
                    :bracketed {:indent {:options {:change_type :diff}}}
                    :comment {}
                    :completion {}
                    :cursorword {}
                    :indentscope {}
                    :move {}
                    :splitjoin {}
                    ; :starter (require :plugins.mini.starter)
                    :statusline {}
                    :tabline {}
                    :trailspace {}}))]
