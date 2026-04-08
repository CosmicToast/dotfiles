;; -*- lexical-binding: t; -*-
;;; prelude
(loadil 'init.d/xdg)
(loadil 'init.d/package)
(load custom-file 'noerror nil 'nosuffix) ; custom-file is set in init.d/xdg

;;; globals
(setopt
  enable-recursive-minibuffers t
  read-extended-command-predicate #'command-completion-default-include-p
  eglot-autoshutdown t)

(setq-default
  indent-tabs-mode nil)

(oven/bind "C-<tab>" #'completion-at-point)

(editorconfig-mode 1)
(savehist-mode 1)

;;; basics
(loadil 'init.d/ui)   ; colors, cli
(loadil 'init.d/ux)   ; verti&co, devil, multiple-cursors, magit…
(loadil 'init.d/term) ; using emacs as/in a terminal emulator

;;; langs
;; initial setup
(require 'treesit)
(add-to-list 'treesit-extra-load-path (xdg/usr "tree-sitter/"))

(loadil 'lang.d/c) ; c/c++ and c-likes (odin, zig…)
(loadil 'lang.d/go)
(loadil 'lang.d/lisp) ; including parinfer, elisp, fennel, janet…
(loadil 'lang.d/js) ; including qml
(loadil 'lang.d/lua) ; not including fennel
(loadil 'lang.d/markup) ; inc. markdown, excluding org
(loadil 'lang.d/org)
(loadil 'lang.d/shell) ; all shells

;; various emacs settings and hooks
;; When a server frame is created, try to force-focus it.
(with-hook 'server-after-make-frame-hook
  (select-frame-set-input-focus (selected-frame)))

;; When the last visible frame is closed, reset emacs.
(with-abnormal-hook 'delete-frame-functions (frame)
  (when (--all? ; if we're deleting the last real frame
         (or (eq it frame)
             (string-equal "initial_terminal" (terminal-name it)))
         (frame-list))
    (mapc #'kill-buffer
          (--remove
           (string-prefix-p " " (buffer-name it))
           (buffer-list)))
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (cd "~")))))

(loadi "local")

;;; Language Support
;; Things that add or improve support for various languages / modes in emacs.
;; Typically, this means tree-sitter, plugins, major modes...
;; This excludes LSPs, flycheck, and similar though.

;; General: Tree-Sitter
(comment (require 'treesitter) ; my helper library
  (add-to-list 'treesit-extra-load-path (xdg/usr "tree-sitter/")))
