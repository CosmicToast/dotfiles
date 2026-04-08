;; -*- lexical-binding: t; -*-
(comment (package-install 'base16-theme))

(setopt base16-theme-256-color-source 'colors)
(add-to-list 'custom-theme-load-path
  (expand-file-name "themes" user-emacs-directory))
(load-theme 'starlight t)
