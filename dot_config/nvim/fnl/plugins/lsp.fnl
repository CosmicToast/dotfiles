(import-macros {:mixed-table · : recc} :toast.macros)
(local {: assoc : map} (require :toast.core))
(local {: insert} (require :toast.table))
(local {: executable?} (require :toast.nvim))

(fn gopts [plist]
  {:basedpyright {}
   :clangd {}
   :clojure_lsp {:root_dir (plist :project.clj :deps.edn :bb.edn :build.boot :shadow-cljs.edn :.git)}
   :denols {:autostart false
            :root_dir (plist :deno.json :deno.jsonc)}
   :gopls {}
   :ltex {}
   :lua_ls {}
   :ruff {:cmd [:ruff :server :--preview]}
   :texlab {:filetypes [:tex :plaintex :bib :latex]}
   :ts_ls {:autostart false
           :root_dir (plist :tsconfig.json :jsconfig.json :package.json)}
   :zls {}})

; default on-attach
(fn attach [c b]
  (let [lsp vim.lsp
        lbf lsp.buf
        ll  [;groups
             (· "" & :group :+lsp)
             (· :w & :group :+workspace)
             ; actions
             (· :D lbf.declaration     & :desc "goto declaration")
             (· :d lbf.definition      & :desc "goto definition")
             (· :k lbf.hover           & :desc "hover")
             (· :K lbf.signature_help  & :desc "signature help")
             (· :i lbf.implementation  & :desc "goto implementation")
             (· :t lbf.type_definition & :desc "goto type definition")
             (· :r lbf.rename          & :desc "rename")
             (· :c lbf.code_action     & :desc "code action")
             (· :R lbf.reference       & :desc "list references")]
        ll (map #(assoc $ 1 (.. :<localleader><localleader> (. $ 1))) ll)]
   (vim.api.nvim_buf_set_option b :omnifunc :v:lua.vim.lsp.omnifunc)
   (recc :which-key :add
         (· (insert ll
                    (· :<leader>F #(vim.lsp.buf.format {:async true}) &
                       :desc "run format")) &
            :buffer b))))

[(· :neovim/nvim-lspconfig &
    :config (fn [_ opts]
             (each [k v (pairs opts)]
              (let [s (. (require :lspconfig) k)
                    c (or v.cmd s.document_config.default_config.cmd)
                    att (or v.on_attach attach)]
                 (when (executable? (. c 1))
                  (s.setup (assoc v :on_attach att))))))
    :opts #(gopts (partial recc :lspconfig.util :root_pattern)))]
