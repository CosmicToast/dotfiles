(import-macros {: recc} :toast.macros)

; allow running code unconditionally before or after plugins / noplugins are loaded
(fn doif [path]
  (let [path (.. (vim.fn.stdpath :config) :/ path)
        do? (< 0 (vim.fn.filereadable path))]
   (when do? (dofile path))))

; leader, localleader, options
(doif :pre.lua)

; plugins
(if (= 0 (vim.fn.executable :git))
  (doif :noplugins.lua)
  (let [lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim)
        fstat (vim.loop.fs_stat lazypath)]
   (when (not fstat)
    (vim.fn.system [:git
                    :clone
                    :--filter=blob:none
                    :https://github.com/folke/lazy.nvim.git
                    :--branch=stable ; latest stable release
                    lazypath]))
   (vim.opt.rtp:prepend lazypath)
   (recc :lazy :setup :plugins {})
   (require :bindings)
   (vim.cmd "colorscheme starlight")))

; custom file associations etc
(doif :post.lua)
