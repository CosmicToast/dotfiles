;; -*- lexical-binding: t; -*-
(comment
  (progn
    (package-install 'embark-consult)

    (package-install 'embark)
    (package-install 'vertico)
    (package-install 'orderless)
    (package-install 'consult)
    (package-install 'marginalia)

    (package-install 'avy)
    (package-install 'multiple-cursors)
    (package-install 'edit-indirect)

    (package-install 'magit)))

(with-package embark
  (setopt
    embark-indicators '(embark-minimal-indicator
                        embark-highlight-indicator
                        embark-isearch-highlight-indicator)
    embark-prompter   #'embark-completing-read-prompter)
  (oven/bind "C-." #'embark-act
    "M-." #'embark-dwim))

(with-package vertico
  (vertico-mode 1)
  (vertico-multiform-mode 1)
  (vertico-flat-mode 1)

  ;; I do want to see dotfiles, but last
  ;; otherwise the default history-length-alpha sort is fine for files
  (defun sort-normal-then-dots (files)
    (let ((all  (vertico-sort-history-length-alpha files))
          (dot? (-partial #'string-prefix-p ".")))
      (nconc (seq-remove dot? all)
             (seq-filter dot? all))))

  (setopt
    vertico-cycle t

    ;; ¯\_(ツ)_/¯
    minibuffer-prompt-properties
    '(read-only t cursor-intangible t face minibuffer-prompt)

    vertico-multiform-categories
    '((file (vertico-sort-function . sort-normal-then-dots))
      (embark-keybinding (:not flat) grid)))

  (add-hook 'rfn-shadow-update-overlay-hook #'vertico-directory-tidy)

  (oven/bind vertico-map
    "RET"   #'vertico-directory-enter
    "DEL"   #'vertico-directory-delete-char
    "M-DEL" #'vertico-directory-delete-word))

(with-package orderless
  (setopt
    completion-styles '(orderless basic)
    completion-category-defaults nil

    completion-category-overrides
    '((file (styles partial-completion)))))

(with-package consult
  (setopt completion-in-region-function #'consult-completion-in-region))
;; TODO: else?

;; else?
(comment
  (lambda (start end collection &optional predicate)
   "Prompt for completion of region in the minibuffer if non-unique.
    Use as a value for `completion-in-region-function`.
    From reddit u/O10120240501, based on consult's version."
   (let* ((initial (buffer-substring-no-properties start end))
          (all (completion-all-completions initial collection predicate
                                           (length initial)))
          (completion (cond
                       ((atom all) nil)
                       ((and (consp all) (atom (cdr all))) (car all))
                       (t (completing-read
                           "Completion: " collection predicate t initial)))))
     (cond (completion (completion--replace start end completion) t)
           (t (message "No completion") nil)))))

(with-package marginalia)

(with-package avy
  (oven/bind "C-;"   #'avy-goto-char-timer)
  (oven/bind "C-S-l" #'avy-goto-line))

(with-package multiple-cursors
  (setopt mc/list-file (xdg/var "mc-lists.el"))
  (oven/bind "C->"     #'mc/mark-next-like-this
             "C-<"     #'mc/mark-previous-like-this
             "C-c C-<" #'mc/mark-all-like-this
             "C-c C-a" #'mc/edit-beginnings-of-lines
             "C-c C-e" #'mc/edit-ends-of-lines))

;;(require 'devil) ; TODO: remove in 31.1?
(global-devil-mode 1)

(add-to-list-many
  'devil-repeatable-keys
  '("%k >" "%k <"))

(add-to-list-many
  'devil-special-keys
  `("%k (" . ,(devil-key-executor "%k ("))  ; unquoting a form
  `("%k @" . ,(devil-key-executor "%k @"))) ; unquoting and splicing

(setopt devil-exit-key "<ESC>")

;; devil-specifics using embark
(with-package embark
  (setopt prefix-help-command #'embark-prefix-help-command)
  (setopt devil-prefix-help-command
    (lambda ()
      (interactive)
      (when-let ((keys (this-command-keys))
                 (parsed (kbd (devil--translate keys)))
                 (prefix (substring parsed 0 (1- (length parsed))))
                 (keymap (key-binding prefix 'accept-default)))
        (minibuffer-with-setup-hook
          (lambda ()
            (let ((pt (- (minibuffer-prompt-end) 2)))
              (overlay-put (make-overlay pt pt) 'before-string
                           (format " under %s" (key-description prefix)))))
          (embark-bindings-in-keymap keymap))))))

(with-package magit
  (oven/bind "C-c g" #'magit-status
             "C-c G" #'magit-dispatch
             "C-c f" #'magit-file-dispatch))
