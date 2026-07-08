; custom filetypes
(local fts [{:extension {:janet :janet}}
            {:extension {:cls   :latex}}])
(each [_ v (ipairs fts)] (vim.filetype.add v))
