(import-macros {:mixed-table · : recc} :toast.macros)
(local {: assoc : map} (require :toast.core))
(local {: insert} (require :toast.table))

(fn [c b]
  (let [lsp vim.lsp
        lbf lsp.buf
        ll  [(· "" & :group :+lsp)
             (· :w & :group :+workspace)

             (· :D lbf.declaration     & :desc "goto declaration")
             (· :d lbf.definition      & :desc "goto definition")
             (· :k lbf.hover           & :desc "hover")
             (· :K lbf.signature_help  & :desc "signature help")
             (· :i lbf.implementation  & :desc "goto implementation")
             (· :t lbf.type_definition & :desc "goto type definition")
             (· :r lbf.rename          & :desc "rename")
             (· :c lbf.code_action     & :desc "code action")
             (· :R lbf.reference       & :desc "list references")

             (· :wa lbf.add_workspace_folder    & :desc "add folder")
             (· :wr lbf.remove_workspace_folder & :desc "remove folder")
             (· :wl #(print (vim.inspect (lbf.list_workspace_folders))) &
                :desc "list folders")]
        ll (map #(assoc $ 1 (.. :<localleader><localleader> (. $ 1))) ll)]
   (vim.api.nvim_buf_set_option b :omnifunc :v:lua.vim.lsp.omnifunc)
   (recc :which-key :add
         (· (insert ll
                    (· :<leader>F #(vim.lsp.buf.format {:async true}) &
                       :desc "run format")) &
            :buffer b))))
