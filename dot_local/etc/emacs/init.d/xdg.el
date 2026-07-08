;; -*- lexical-binding: t; -*-
;; move stuff out of ~/.config/emacs
;; depends on elisp/xdg.el

(setopt
 auth-sources `(,(xdg/var "authinfo")
                "~/.authinfo" "~/.netrc") ; compat
 ;; auto-save files look like this: .saves-
 ;; they are created when you haven't saved the file in a while,
 ;; and are used to restore what you were working on in case of
 auto-save-list-file-prefix (xdg/var! "autosave/.saves-")
 auto-save-file-name-transforms `((".*" ,(xdg/var "autosave/\\1") t))

 ;; when you save a file, emacs copies the old contents to a backup file,
 ;; in case you messed something up. It can save >1 versions too.
 backup-directory-alist `((".*" . ,(xdg/var "backup/")))

 ;; the customization UI writes to this
 ;; I don't use it, but it gets triggered by various things anyway.
 custom-file (xdg/var "custom.el")

 ;; eshell and shell modes provide a shell to slap into terminal emulators
 eshell-directory-name          (xdg/var! "eshell")
 eshell-history-file-name       (xdg/var "eshell/history.el")
 eshell-last-dir-ring-file-name (xdg/var "eshell/lastdir")
 shell-history-file-name        (xdg/var "shell/history.el")

 ;; lock-files look like .#name and help when multiple users are editing
 ;; the same files. I don't really use that functionality though.
 lock-file-name-transforms `((".*" ,(xdg/var! "lock/\\1") t))

 multisession-directory (xdg/var "multisession/")

 ;; emacs keeps track of known projects
 project-list-file (xdg/var "projects.el")

 ;; minibuffer history, especially useful for vertico
 savehist-file (xdg/var "history.el")

 ;; SLIME is a Common Lisp REPL
 slime-repl-history-file (xdg/var! "slime/history.eld")
 slime-compile-file-options `(:fasl-directory ,(xdg/var! "slime/fasl/"))

 ;; TRAMP is the remote editing system.
 tramp-persistency-file-name (xdg/var "tramp/history.el")

 ;; I'm honestly not sure what these are.
 transient-levels-file  (xdg/var "transient/levels.el")
 transient-values-file  (xdg/var "transient/values.el")
 transient-history-file (xdg/var "transient/history.el")

 ;; url-mode is the embedded browser
 url-configuration-directory (xdg/var "url")
 url-history-file            (xdg/var "url/history.el"))
