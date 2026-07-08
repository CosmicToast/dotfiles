;; -*- lexical-binding: t; -*-

(add-to-list-many 'treesit-language-source-alist
  '(go    . ("https://github.com/tree-sitter/tree-sitter-go"))
  '(gomod . ("https://github.com/camdencheek/tree-sitter-go-mod")))

(comment
  (ts-install-grammar 'go)
  (ts-install-grammar 'gomod))

;; eglot supports gopls by default
