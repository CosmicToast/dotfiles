;; -*- lexical-binding: t; -*-
;;; C
(add-hook 'c-mode-hook   #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)

;;; Odin
(comment
  (package-vc-install "https://git.sr.ht/~mgmarlow/odin-mode"))

;;; Zig
