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
                :wrap true})

(each [k v (pairs options)]
  (tset vim.opt k v))
