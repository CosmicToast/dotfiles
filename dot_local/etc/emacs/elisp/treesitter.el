;;; treesitter.el --- Treesitter manager. -*- lexical-binding: t; -*-

;; Copyright (c) 2025 Chloé VULQUIN

;; Author: Chloé VULQUIN <toast@bunkerlabs.net>
;; Maintainer: Chloé VULQUIN <toast@bunkerlabs.net>
;; License: 0BSD OR BlueOak-1.0.0 OR CC0-1.0 OR MIT

;; This file is part of your Emacs install if you download it :)

;;; Commentary:

;; This file defines `treesit-languages-alist' as a var, watchers for it,
;; and functions that can use/manipulate it.
;; This exists in order to allow you to handle treesitter grammars more easily.
;; Look at my dotfiles and its documentation if you want more details :)

;; One big warning though: you should *not* try to manage other settings otherwise.
;; `treesit-languages-alist''s watcher *will* overwrite your other changes.

;;; Code:

(defvar treesit-languages-alist '()
  "Your one-stop shop to manage treesit languages.

   This is an alist from car (the language name as a symbol) to cdr (another alist).
   You can think of it as a map of objects.
   The objects support the following properties:

   `mode', whose value will be used in `remaps'.
   If unspecified, `-ts-mode' will be appended to the language name.

   `source', whose value will be passed on directly to `treesit-language-source-alist'.
   This means that if you \"just\" want an unversioned repo,
   it must still be a list, like `(\"https://example.com/my-repo\")`.

   `remaps', which is a list of modes to remap to `mode'.")

(defun treesit-language-source-alist* (ts-languages-alist)
  "Generates a `treesit-language-source-alist' list
   from a `treesit-languages-alist' list."
  (mapcar (lambda (ts-language) (cons (car ts-language)
                                      (alist-get 'source (cdr ts-language))))
          ts-languages-alist))
(defun major-mode-remap-alist* (ts-languages-alist)
  "Generates a `major-mode-remap-alist' list
   from a `treesit-languages-alist' list."
  (mapcan (lambda (ts-language)
            (if-let* ((name-sym (car ts-language))
                      (available? (treesit-language-available-p name-sym))
                      (attrs (cdr ts-language))
                      (mode (or (alist-get 'mode attrs)
                                (intern (concat (symbol-name name-sym)
                                                "-ts-mode")))))
                (when available?
                  (mapcar (lambda (sym) (cons sym mode)) (alist-get 'remaps attrs)))))
          ts-languages-alist))

(add-variable-watcher
 'treesit-languages-alist
 (lambda (symbol newval operation where)
   (when (eq operation 'set)
     (setq treesit-language-source-alist (treesit-language-source-alist* newval)
           major-mode-remap-alist        (major-mode-remap-alist*        newval)))))

;;;###autoload
(defun ts-install-grammar (gram)
  "Installs a grammar defined in `treesit-languages-alist'.
   It will be installed in the first directory of `treesit-extra-load-path',
   else into the default location (\"tree-sitter\" subdir of `user-emacs-directory'."
  (interactive (list (completing-read "Grammar to install: "
                                      (mapcar #'car treesit-languages-alist))))
  (treesit-install-language-grammar
   (if (stringp gram)
       (intern gram) gram)
   (or (car treesit-extra-load-path)
       (concat user-emacs-directory "tree-sitter"))))

;;;###autoload
(defun ts-install-all-grammars ()
  "Installs all not currently installed grammars in `treesit-languages-alist'
   by calling `ts-install-grammar' repeatedly."
  (interactive)
  (dolist (langd treesit-languages-alist)
    (unless (treesit-language-available-p (car langd))
      (ts-install-grammar (car langd)))))

;;;###autoload
(defun ts-update-grammars ()
  "Updates all installed grammars in `treesit-languages-alist'
   by calling `ts-install-grammar' repeatedly."
  (interactive)
  (dolist (langd treesit-languages-alist)
    (when (treesit-language-available-p (car langd))
      (ts-install-grammar (car langd)))))

(provide 'treesitter)
