(import-macros {: tbl : recc} :toast.macros)
(local {: assoc : map} (require :toast.core))
(local {: insert} (require :toast.table))

(fn [c b]
  (let [lsp vim.lsp
        lbf lsp.buf
        ll  [(tbl "" & :group :+lsp)
             (tbl :w & :group :+workspace)

             (tbl :D lbf.declaration     & :desc "goto declaration")
             (tbl :d lbf.definition      & :desc "goto definition")
             (tbl :k lbf.hover           & :desc "hover")
             (tbl :K lbf.signature_help  & :desc "signature help")
             (tbl :i lbf.implementation  & :desc "goto implementation")
             (tbl :t lbf.type_definition & :desc "goto type definition")
             (tbl :r lbf.rename          & :desc "rename")
             (tbl :c lbf.code_action     & :desc "code action")
             (tbl :R lbf.reference       & :desc "list references")

             (tbl :wa lbf.add_workspace_folder    & :desc "add folder")
             (tbl :wr lbf.remove_workspace_folder & :desc "remove folder")
             (tbl :wl #(print (vim.inspect (lbf.list_workspace_folders))) &
                :desc "list folders")]
        ll (map #(assoc $ 1 (.. :<localleader><localleader> (. $ 1))) ll)]
   (vim.api.nvim_buf_set_option b :omnifunc :v:lua.vim.lsp.omnifunc)
   (recc :which-key :add
         (tbl (insert ll
                      (tbl :<leader>F #(vim.lsp.buf.format {:async true}) &
                         :desc "run format")) &
            :buffer b))))
