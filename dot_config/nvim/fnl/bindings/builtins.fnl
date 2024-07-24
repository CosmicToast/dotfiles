; document missing builtins
(import-macros {: tbl : recc} :toast.macros)
(recc :which-key :add
 [(tbl :gt & :desc "Next tab")
  (tbl :gT & :desc "Previous tab")])
