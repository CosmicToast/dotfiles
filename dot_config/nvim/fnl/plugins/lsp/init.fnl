(import-macros {:mixed-table · : recc} :toast.macros)
(local {: assoc} (require :toast.core))
(local {: executable?} (require :toast.nvim))

(fn gopts [plist]
  {:clangd {}
   :clojure_lsp {:root_dir (plist :project.clj :deps.edn :bb.edn :build.boot :shadow-cljs.edn :.git)}
   :denols {:autostart false
            :root_dir (plist :deno.json :deno.jsonc)}
   :gopls {}
   :ltex {}
   :lua_ls {}
   :pyright {}
   :ruff {:cmd [:ruff :server :--preview]}
   :texlab {:filetypes [:tex :plaintex :bib :latex]}
   :tsserver {:autostart false
              :root_dir (plist :tsconfig.json :package.json)}
   :zls {}})

(local attach (require :plugins.lsp.attach))

[(· :neovim/nvim-lspconfig &
    :config (fn [_ opts]
             (each [k v (pairs opts)]
              (let [s (. (require :lspconfig) k)
                    c (or v.cmd s.document_config.default_config.cmd)
                    att (or attach v.on_attach)]
                 (when (executable? (. c 1))
                  (s.setup (assoc v :on_attach att))))))
    :opts #(gopts (partial recc :lspconfig.util :root_pattern)))]
