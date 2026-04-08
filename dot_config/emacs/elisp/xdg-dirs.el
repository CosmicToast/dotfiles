;;; xdg.el --- Utilities to help with XDG base directory compliance. -*- lexical-binding: t; -*-

;; Copyright (c) 2025 Chloé VULQUIN

;; Author: Chloé VULQUIN <toast@bunkerlabs.net>
;; Maintainer: Chloé VULQUIN <toast@bunkerlabs.net>
;; License: 0BSD OR BlueOak-1.0.0 OR CC0-1.0 OR MIT

;; This file is part of your Emacs install if you download it :)

;;; Commentary:

;; This file contains helpers for XDG compliance.
;; It will detect your system's setup when you first require it,
;; saving the canonical locations for config, cache, data, and state homes.
;; It then provides a few functions to utilize this information effectively.

;; For further details on what this is and why you might want it,
;; have a read through https://specifications.freedesktop.org/basedir-spec/latest/

;;; Code:

;;; Core functionality

;; These are detected require-time and should not be changed.
;; Trust me. You do not want to change them.
;; If you think you want to change them, restart emacs and do it externally.
(defun xdg--getenv-expand-default (env def)
  (expand-file-name (or (getenv env) def)))

(defconst xdg/config-home
  (xdg--getenv-expand-default "XDG_CONFIG_HOME" "~/.config")
  "Represents XDG_CONFIG_HOME, where user-specific configuration should be written.
   `xdg/config-home`/emacs should be the emacs-user-dir.
   Equivalent to /etc.")
(defconst xdg/cache-home
  (xdg--getenv-expand-default "XDG_CACHE_HOME" "~/.cache")
  "Represents XDG_CACHE_HOME,
   where user-specific non-essential data should be written.
   Equivalent to /var/cache or /tmp.")
(defconst xdg/data-home
  (xdg--getenv-expand-default "XDG_DATA_HOME" "~/.local/share")
  "Represents XDG_DATA_HOME, where user-specific data files should be written.
   Equivalent to /usr/share.")
(defconst xdg/state-home
  (xdg--getenv-expand-default "XDG_STATE_HOME" "~/.local/state")
  "Represents XDG_STATE_HOME, where user-specific state files should be written.
   Equivalent to /var/lib.")

(defun xdg/config-file (path)
  "Generate a path relative to $XDG_CONFIG_HOME/emacs/.
   Use this when you'd use /etc/emacs globally."
  (file-name-concat xdg/config-home "emacs" path))
(defun xdg/cache-file (path)
  "Generate a path relative to $XDG_CACHE_HOME/emacs/.
   Use this when you'd use /var/cache/emacs or /tmp/emacs globally."
  (file-name-concat xdg/cache-home "emacs" path))
(defun xdg/data-file (path)
  "Generate a path relative to $XDG_DATA_HOME/emacs/.
   Use this when you'd use /usr/share/emacs globally."
  (file-name-concat xdg/data-home "emacs" path))
(defun xdg/state-file (path)
  "Generate a path relative to $XDG_STATE_HOME/emacs/.
   Use this when you'd use /var/lib/emacs globally."
  (file-name-concat xdg/state-home "emacs" path))

;; shorter aliases
(defalias 'xdg/etc #'xdg/config-file)
(defalias 'xdg/tmp #'xdg/cache-file)
(defalias 'xdg/usr #'xdg/data-file)
(defalias 'xdg/var #'xdg/state-file)

;;; Helpers

;; Equivalent to xdg/* but they make sure the directory is created.
(defun xdg/some--file! (fun path)
  "Worker function for the some-file* family of helpers."
  (let* ((res (funcall fun path))
         (dir (file-name-directory res)))
    (make-directory dir t)
    res))
(defun xdg/config-file! (path)
  "Generate a path relative to $XDG_CONFIG_HOME/emacs/.
   Use this when you'd use /etc/emacs globally.
   This variant ensures that the parent directory of the resulting path exists."
  (xdg/some--file! #'xdg/config-file path))
(defun xdg/cache-file! (path)
  "Generate a path relative to $XDG_CACHE_HOME/emacs/.
   Use this when you'd use /var/cache/emacs or /tmp/emacs globally.
   This variant ensures that the parent directory of the resulting path exists."
  (xdg/some--file! #'xdg/cache-file path))
(defun xdg/data-file! (path)
  "Generate a path relative to $XDG_DATA_HOME/emacs/.
   Use this when you'd use /usr/share/emacs globally.
   This variant ensures that the parent directory of the resulting path exists."
  (xdg/some--file! #'xdg/data-file path))
(defun xdg/state-file! (path)
  "Generate a path relative to $XDG_STATE_HOME/emacs/.
   Use this when you'd use /var/lib/emacs globally.
   This variant ensures that the parent directory of the resulting path exists."
  (xdg/some--file! #'xdg/state-file path))

;; equivalent aliases
(defalias 'xdg/etc! #'xdg/config-file!)
(defalias 'xdg/tmp! #'xdg/cache-file!)
(defalias 'xdg/usr! #'xdg/data-file!)
(defalias 'xdg/var! #'xdg/state-file!)

;;; patches
;; Some of these things are expected, but not present, at least on my system.
;; For example, when I require 'tramp,
;; it fails due to no definition for (xdg-cache-home).
(unless (fboundp 'xdg-cache-home)
  (fset 'xdg-cache-home (lambda (&rest _) xdg/cache-home)))

(provide 'xdg-dirs)
;;; xdg.el ends here
