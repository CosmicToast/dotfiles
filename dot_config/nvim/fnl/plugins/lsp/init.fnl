(import-macros {:mixed-table · : recc} :toast.macros)

(fn gopts [plist]
  {:clangd {}
   :clojure_lsp {:root_dir (plist :project.clj :deps.edn :bb.edn :build.boot :shadow-cljs.edn :.git)}
   :denols {:autostart false
            :root_dir (plist :deno.json :deno.jsonc)}
   :gopls {}
   :ltex {}
   :lua_ls {}
   :texlab {:filetypes [:tex :plaintex :bib :latex]}
   :tsserver {:autostart false
              :root_dir (plist :tsconfig.json :package.json)}
   :zls {}})

(local attach (require :plugins.lsp.attach))
(local caps   (require :plugins.lsp.capabilities))

[(· :neovim/nvim-lspconfig &
    :config (fn [_ opts]
             (each [k v (pairs opts)]
              (set v.on_attach (or attach v.on_attach))
              (when (= :table (type caps))
               (set v.capabilities (or v.capabilities caps)))
              (let [s (. (require :lspconfig) k)
                    c (or v.cmd s.document_config.default_config.cmd)]
               (when (not= 0 (vim.fn.executable (. c 1)))
                (s.setup v)))))
    :opts (fn []
           (let [plist (fn [...]
                        (local p (recc :lspconfig.util :root_pattern ...))
                        #(p $))]
            (gopts plist))))]
