;;; oven.el --- Functions are preparing, please wait warmly -*- lexical-binding: t; -*-

;; Copyright (c) 2025 Chloé VULQUIN

;; Author: Chloé VULQUIN <toast@bunkerlabs.net>
;; Maintainer: Chloé VULQUIN <toast@bunkerlabs.net>
;; License: 0BSD OR BlueOak-1.0.0 OR CC0-1.0 OR MIT

;; This file is part of your Emacs install if you download it :)

;;; Commentary:

;; This file contains all of my helper functions etc I miss in elisp.
;; In some cases, this might trample over existing symbols.
;; Use at your own risk!

;;; Code:

(defun add-to-list-many (list &rest elems)
  "Calls add-to-list on LIST for every ELEMS."
  (mapc (apply-partially #'add-to-list list) (nreverse elems)))

(defmacro comment (&rest body) "Removes all child forms." '()) ; :)

(defun require* (feature &optional filename)
  "Safe variant of `require' that sends a message if it fails."
  (unless (require feature filename 'noerror)
    (message "failed to load %s" (symbol-name feature))))

(defun coercepc (value predicate converter)
  "If VALUE matches PREDICATE, return (CONVERTER VALUE), else value."
  (funcall (if (funcall predicate value)
             converter #'identity)
           value))

(defun loadi (name)
  "Loads NAME which may be a symbol under user-emacs-directory,
   ignoring errors and requiring NAME to not be suffixed."
  (load (expand-file-name
          (coercepc name #'symbolp #'symbol-name)
          user-emacs-directory)
        'noerror nil nil 'must-suffix))
(defun loadil (name)
  "Like `loadi' but also tries to load name-local."
  (loadi name)
  (loadi (concat (coercepc name #'symbolp #'symbol-name)
                 "-local")))

(defmacro with-hook (hook &rest body)
  "Runs `add-hook' on HOOK, placing BODY in an implicit lambda."
  (declare (indent defun))
  `(add-hook ,hook (lambda () ,@body)))
(defmacro with-abnormal-hook (hook args &rest body)
  "Like `with-hook' but works on abnormal hooks, binding ARGS."
  (declare (indent defun))
  `(add-to-list ,hook (lambda ,args ,@body)))
(defalias 'with-load #'with-eval-after-load)

;; I use the following macros to replace use-package
(defmacro with-package (package &rest body)
  "Runs BODY if PACKAGE is installed. PACKAGE may be a list of packages, in
which case they must all be installed."
  (declare (indent defun))
  (pcase (type-of package)
    ('symbol `(when (package-installed-p ',package)
                ,@body))
    ('cons   `(when (cl-every #'package-installed-p ',package)
                ,@body))))
(defun oven/bind* (map args)
  (when args
    (let* ((key (car args))
           (nxt (cdr args))
           (val (car nxt)))
      (keymap-set map key val)
      (oven/bind* map (cdr nxt)))))
(defun oven/bind (&rest args)
  "Set some keybinds ala `setopt'. If the first argument is a keymap,
sets them in that keymap, else sets them in the global keymap."
  (let ((map (current-global-map))
        (args args)
        (acar (car args)))
    (when (keymapp acar)
      (setq map  acar
            args (cdr args)))
    (oven/bind* map args)))

(defun read-all (&optional stream)
  "Read every Lisp expression as text from STREAM, return as Lisp list of
objects. If STREAM is nil or an unrecognized type, uses
`current-buffer'."
  (cond
   ((bufferp stream)
    (save-excursion
      (let ((buf (current-buffer))
            forms)
        (goto-char (point-min))
        (while (ignore-errors (push (read buf) forms)))
        (nreverse forms))))
   ((stringp stream)
    (with-temp-buffer
      (insert stream)
      (read-all (current-buffer))))
   (t (read-all (current-buffer)))))

(defun occur-sexpr (sym)
  "Show all occurrences of the function SYM being called at the top level
of the current buffer. Intended to be used with an alias of `comment'."
  (interactive "Search for symbol: ")
  (let* ((buf   (get-buffer-create "*occur-sexpr*"))
         (forms (read-all)))
    (switch-to-buffer-other-window buf)
    (erase-buffer)
    (mapc (lambda (body)
            (dolist (form (cdr body))
              (pp form buf)))
          (seq-filter
           (lambda (form)
             (eq sym (car-safe form)))
           forms))
    (lisp-interaction-mode)
    (read-only-mode t)))

(provide 'oven)
