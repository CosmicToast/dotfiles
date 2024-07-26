(import-macros {:mixed-table · : recc} :toast.macros)

(each [_ v (ipairs [:builtins
                    :plugins])]
  (require (.. :bindings. v)))

; general bindings that aren't specific to a plugin
(recc :which-key :add
  ; diagnostics
 [(· :<leader>e vim.diagnostic.open_float & :desc "diag float")
  (· :<leader>q vim.diagnostic.setloclist & :desc "diag locations")
  (· "[d"       vim.diagnostic.goto_prev  & :desc "prev diag")
  (· "]d"       vim.diagnostic.goto_next  & :desc "next diag")])
