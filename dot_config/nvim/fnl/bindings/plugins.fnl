; plugin-specific category bindings
(import-macros {:mixed-table · : recc} :toast.macros)
(recc :which-key :add
 [(· :<leader>f & :desc :+find)])
