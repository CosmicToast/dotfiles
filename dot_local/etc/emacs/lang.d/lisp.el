;; -*- lexical-binding: t; -*-

;; All Lisps
;; TODO: maybe bundle it? I'm still not very happy about the rust bit
;; consider: lispy with 'parinfer key theme?
(comment (package-install 'parinfer-rust-mode))
(with-package parinfer-rust-mode
  (let* ((libdir (xdg/usr  "lib/"))
         (prflib (xdg/usr! "lib/parinfer_rust.so"))
         (prf?   (file-exists-p prflib)))
    (if prf?
      (setopt parinfer-rust-library prflib)
      (setopt parinfer-rust-library-directory libdir
              parinfer-rust-auto-download     t)))
  (with-load 'parinfer-rust-mode
    (plist-put parinfer-rust-major-mode-options
      'janet-ts-mode parinfer-rust-janet-options))
  (dolist (hook '(clojure-mode-hook
                  emacs-lisp-mode-hook
                  janet-ts-mode-hook
                  lisp-mode-hook))
    (add-hook hook #'parinfer-rust-mode)))

;; Fennel
(comment
  (package-install 'fennel-mode))

;; Janet
(add-to-list 'treesit-language-source-alist
  '(janet-simple . ("https://github.com/sogaiu/tree-sitter-janet-simple")))

(comment
  (ts-install-grammar 'janet-simple)
  (dolist (repo '("https://github.com/sogaiu/janet-ts-mode.git"
                  "https://github.com/sogaiu/ajrepl.git"
                  "https://github.com/sogaiu/flycheck-janet.git"))
    (package-vc-install repo)))

(with-package (ajrepl flycheck-janet)
  (add-hook 'janet-ts-mode-hook #'ajrepl-interaction-mode)
  (with-load 'flycheck
    (require 'flycheck-janet)))
