;; -*- lexical-binding: t; -*-
(require 'base16-theme)

(defvar starlight-colors
  '(:black     "#242424"
    :brblack   "#616161"
    :red       "#f62b5a"
    :brred     "#ff4d51"
    :green     "#47b413"
    :brgreen   "#35d450"
    :yellow    "#e3c401"
    :bryellow  "#e9e836"
    :blue      "#24acd4"
    :brblue    "#5dc5f8"
    :magenta   "#f2affd"
    :brmagenta "#feabf2"
    :cyan      "#13c299"
    :brcyan    "#24dfc4"
    :white     "#e6e6e6"
    :brwhite   "#ffffff")
  "The Starlight ANSI color palette.")

(defun starlight-color (color) (plist-get starlight-colors color))

(defvar base16-starlight-colors
  `(:base00 ,(starlight-color :black)
    ;; linearly interpolated from :black to :brblack
    :base01 "#383838"
    :base02 "#4d4d4d"
    :base03 ,(starlight-color :brblack)
    :base04 ,(starlight-color :white)
    ;; linearly interpolated from :white to :brwhite
    :base05 "#eeeeee"
    :base06 "#f7f7f7"
    :base07 ,(starlight-color :brwhite)

    ;; based on base16 onedark-based recommendations
    :base08 ,(starlight-color :brred)
    :base09 ,(starlight-color :yellow)
    :base0A ,(starlight-color :bryellow)
    :base0B ,(starlight-color :green)
    :base0C ,(starlight-color :cyan)
    :base0D ,(starlight-color :blue)
    :base0E ,(starlight-color :magenta)
    :base0F ,(starlight-color :red))
   "Bindings of the Starlight colors to the Base16 scheme.")

(deftheme starlight
  "Starlight theme"
  :kind 'color-scheme
  :background-mode 'dark)

(base16-theme-define 'starlight base16-starlight-colors)

(defun starlight-genface (color)
  (list (list t
              (list :background (starlight-color color)
                    :foreground (starlight-color color)))))

(custom-theme-set-faces
 'starlight
 `(ansi-color-black   ,(starlight-genface :black))
 `(ansi-color-red     ,(starlight-genface :red))
 `(ansi-color-green   ,(starlight-genface :green))
 `(ansi-color-yellow  ,(starlight-genface :yellow))
 `(ansi-color-blue    ,(starlight-genface :blue))
 `(ansi-color-magenta ,(starlight-genface :magenta))
 `(ansi-color-cyan    ,(starlight-genface :cyan))
 `(ansi-color-white   ,(starlight-genface :white))
 `(ansi-color-bright-black   ,(starlight-genface :brblack))
 `(ansi-color-bright-red     ,(starlight-genface :brred))
 `(ansi-color-bright-green   ,(starlight-genface :brgreen))
 `(ansi-color-bright-yellow  ,(starlight-genface :bryellow))
 `(ansi-color-bright-blue    ,(starlight-genface :brblue))
 `(ansi-color-bright-magenta ,(starlight-genface :brmagenta))
 `(ansi-color-bright-cyan    ,(starlight-genface :brcyan))
 `(ansi-color-bright-white   ,(starlight-genface :brwhite))

 '(term-color-black   ((t (:inherit (ansi-color-black)))))
 '(term-color-red     ((t (:inherit (ansi-color-red)))))
 '(term-color-green   ((t (:inherit (ansi-color-green)))))
 '(term-color-yellow  ((t (:inherit (ansi-color-yellow)))))
 '(term-color-blue    ((t (:inherit (ansi-color-blue)))))
 '(term-color-magenta ((t (:inherit (ansi-color-magenta)))))
 '(term-color-cyan    ((t (:inherit (ansi-color-cyan)))))
 '(term-color-white   ((t (:inherit (ansi-color-white)))))
 '(term-color-bright-black   ((t (:inherit (ansi-color-bright-black)))))
 '(term-color-bright-red     ((t (:inherit (ansi-color-bright-red)))))
 '(term-color-bright-green   ((t (:inherit (ansi-color-bright-green)))))
 '(term-color-bright-yellow  ((t (:inherit (ansi-color-bright-yellow)))))
 '(term-color-bright-blue    ((t (:inherit (ansi-color-bright-blue)))))
 '(term-color-bright-magenta ((t (:inherit (ansi-color-bright-magenta)))))
 '(term-color-bright-cyan    ((t (:inherit (ansi-color-bright-cyan)))))
 '(term-color-bright-white   ((t (:inherit (ansi-color-bright-white)))))

 '(eat-term-color-black   ((t (:inherit (ansi-color-black)))))
 '(eat-term-color-red     ((t (:inherit (ansi-color-red)))))
 '(eat-term-color-green   ((t (:inehrit (ansi-color-green)))))
 '(eat-term-color-yellow  ((t (:inherit (ansi-color-yellow)))))
 '(eat-term-color-blue    ((t (:inherit (ansi-color-blue)))))
 '(eat-term-color-magenta ((t (:inherit (ansi-color-magenta)))))
 '(eat-term-color-cyan    ((t (:inherit (ansi-color-cyan)))))
 '(eat-term-color-white   ((t (:inherit (ansi-color-white)))))
 '(eat-term-color-bright-black   ((t (:inherit (ansi-color-bright-black)))))
 '(eat-term-color-bright-red     ((t (:inherit (ansi-color-bright-red)))))
 '(eat-term-color-bright-green   ((t (:inehrit (ansi-color-bright-green)))))
 '(eat-term-color-bright-yellow  ((t (:inherit (ansi-color-bright-yellow)))))
 '(eat-term-color-bright-blue    ((t (:inherit (ansi-color-bright-blue)))))
 '(eat-term-color-bright-magenta ((t (:inherit (ansi-color-bright-magenta)))))
 '(eat-term-color-bright-cyan    ((t (:inherit (ansi-color-bright-cyan)))))
 '(eat-term-color-bright-white   ((t (:inherit (ansi-color-bright-white))))))

;; TODO: go through `base16-theme-define' and just ditch it, lmao.
;; TODO: do something about truecolor; then again I'll always have truecolor.

(provide-theme 'starlight)
(provide 'starlight-theme)
