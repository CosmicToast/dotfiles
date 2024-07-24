(import-macros {: tbl : recc} :toast.macros)

(each [_ v (ipairs [:builtins
                    :plugins])]
  (require (.. :bindings. v)))

; general bindings that aren't specific to a plugin
(recc :which-key :add
  ; diagnostics
 [(tbl :<leader>e vim.diagnostic.open_float & :desc "diag float")
  (tbl :<leader>q vim.diagnostic.setloclist & :desc "diag locations")
  (tbl "[d"       vim.diagnostic.goto_prev  & :desc "prev diag")
  (tbl "]d"       vim.diagnostic.goto_next  & :desc "next diag")])
