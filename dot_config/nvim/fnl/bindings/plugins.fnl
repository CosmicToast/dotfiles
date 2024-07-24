; plugin-specific category bindings
(import-macros {: tbl : recc} :toast.macros)
(recc :which-key :add
 [(tbl :<leader>f & :desc :+find)])
