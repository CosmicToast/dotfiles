(import-macros {:mixed-table ·} :toast.macros)

(local lisps [:clojure
              :fennel
              :janet
              :scm])

; language support
[(· :nvim-treesitter/nvim-treesitter &
    :version false
    :build ::TSUpdate
    :dependnecies [:nvim-treesitter/nvim-treesitter-textobjects]
    :main :nvim-treesitter.configs
    :opts {:ensure_installed :all
           :ignore_install   [:norg]
           :sync_install     :true
           :highlight        {:enable true
                              :disable [:markdown]
                              :additional_vim_regex_highlighting [:markdown]}})
 ; non-treesitter languages
 (· :janet-lang/janet.vim & :ft :janet)
 (· :preservim/vim-markdown &
    :version false
    :dependencies [:godlygeek/tabular]
    :ft :markdown)
 ; helpers for lisps
 (· :gpanders/nvim-parinfer &
    :ft lisps)
 (· :julienvincent/nvim-paredit &
    :ft lisps
    :config {:indent {:enabled true}})]
