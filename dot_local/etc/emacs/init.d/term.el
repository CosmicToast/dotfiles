;; -*- lexical-binding: t; -*-
(comment
  (package-vc-install "https://codeberg.org/akib/emacs-eat" nil nil 'eat)
  (progn (require 'eat) (eat-compile-terminfo))

  (package-install 'kkp))

;; as a terminal
(with-package eat
  (add-hook 'eshell-load-hook #'eat-eshell-mode)
  (setopt eat-enable-kill-from-terminal t
          eat-enable-yank-to-terminal   t))

;; in a terminal
(with-package kkp (global-kkp-mode 1))
(xterm-mouse-mode 1)
