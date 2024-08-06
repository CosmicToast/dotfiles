(import-macros {:mixed-table · : recc} :toast.macros)

(recc :which-key :add
  ; document missing builtins
 [(· :gt & :desc "Next tab")
  (· :gT & :desc "Previous tab")
  ; diagnostics
  (· :<leader>e vim.diagnostic.open_float & :desc "diag float")
  (· :<leader>q vim.diagnostic.setloclist & :desc "diag locations")
  (· "[d"       vim.diagnostic.goto_prev  & :desc "prev diag")
  (· "]d"       vim.diagnostic.goto_next  & :desc "next diag")
  ; plugin groups
  (· :<leader>f & :desc :+find)])
