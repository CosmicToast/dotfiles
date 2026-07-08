;; -*- lexical-binding: t; -*-
(setopt gc-cons-threshold 64000000 ; emacs... 64mb
        load-prefer-newer t ; set before any requires
        native-comp-jit-compilation t
        user-lisp-directory (expand-file-name "elisp" user-emacs-directory)
        user-lisp-autoload-file (expand-file-name
                                  ".user-lisp-autoloads.el"
                                  user-lisp-directory))
(add-to-list 'load-path user-lisp-directory) ; keep even in >31
;; remove in emacs >=31
(when (not (file-exists-p user-lisp-autoload-file))
  (loaddefs-generate user-lisp-directory
                     user-lisp-autoload-file
                     nil ";; tosti"))
(when (file-exists-p user-lisp-autoload-file)
  (load user-lisp-autoload-file nil t))

(require 'dash)
(require 'oven)
(require 'xdg-dirs)

;; these need to be set before init.el starts
(setopt package-user-dir      (xdg/usr "elpa")
        package-gnupghome-dir (xdg/usr "elpa/gnupg"))
(when (boundp 'native-comp-eln-load-path)
  (setcar native-comp-eln-load-path (xdg/tmp "eln")))

;; UI settings set before the UI initializes to avoid reflows
(setopt inhibit-splash-screen t)
(tool-bar-mode -1)

(loadi 'early-local)
