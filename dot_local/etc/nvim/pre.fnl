(import-macros {: recc} :toast.macros)

(set vim.g.mapleader " ")
(set vim.g.maplocalleader "\\")

(local options {:timeoutlen 300
                :clipboard :unnamedplus
                :completeopt "menu,menuone,noselect"
                :mouse :a
                :smartcase true
                :smartindent true
                :backup false
                :swapfile false
                :termguicolors true
                :expandtab false
                :shiftwidth 4
                :tabstop 4
                :number true
                :numberwidth 2
                :scrolloff 4
                :sidescrolloff 4
                :foldmethod :expr
                :foldexpr "nvim_treesitter#foldexpr()"
                :foldlevelstart 99
                :wrap true
                :winborder :rounded})

(each [k v (pairs options)]
  (tset vim.opt k v))

; diagnostics
(vim.diagnostic.config {:virtual_lines true})

; OSC 52 on nvim >= 0.10.0
(let [{: major : minor} (vim.version)]
 (when (or (> major 0) (>= minor 10))
  (set vim.g.clipboard {:name :OSC52
                        :copy  {:+ (recc :vim.ui.clipboard.osc52 :copy  :+)
                                :* (recc :vim.ui.clipboard.osc52 :copy  :*)}
                        :paste {:+ (recc :vim.ui.clipboard.osc52 :paste :+)
                                :* (recc :vim.ui.clipboard.osc52 :paste :*)}})))

; editorconfig extensions
(let [ec (require :editorconfig)]
  (set ec.properties.filetype
       (fn [bufnr val opts]
         (let [bo (. vim.bo bufnr)]
           (when (not= bo.filetype val)
             (set bo.filetype val)
             ; otherwise the change in ft will override editorconfig settings
             (ec.config bufnr))))))

; lsp
(vim.api.nvim_create_autocmd
 :LspAttach
 {:callback
  (fn [ev]
    (let [client (vim.lsp.get_client_by_id ev.data.client_id)]
      (when (client:supports_method :textDocument/completion)
        (vim.lsp.completion.enable true client.id ev.buf
                                   {:autotrigger true}))))})

(vim.lsp.enable [:clangd
                 :clojure_lsp
                 :gopls
                 :lua_ls
                 :ruff
                 :pyright
                 :texlab
                 :ts_ls
                 :zls])
