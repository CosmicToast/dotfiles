(local {: every?} (require :toast.core))

(fn executable? [& paths]
  "Check if every argument specified is an executable that neovim can resolve."
  (every? #(not= 0 (vim.fn.executable $)) paths))

{: executable?}
