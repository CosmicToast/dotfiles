;; -*- lexical-binding: t; -*-

(comment
  (package-vc-install "https://git.sr.ht/~mgmarlow/odin-mode"))

(add-hook 'c-mode-hook   #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)
