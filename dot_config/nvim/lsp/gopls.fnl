{:cmd [:gopls]
 :filetypes [:go :gomod :gowork :gosum]
 :root_dir (fn [buf cb]
             (cb (let  [modr      (vim.fs.root buf  :go.mod)]
                   (or (when modr (vim.fs.root modr :go.work))
                       modr))))
 :settings {:autoformat true
            :gopls {:analyses {:unusedparams true
                               :unusedwrite  true
                               :nilness      true}
                    :gofumpt true
                    :semanticTokens true
                    :staticcheck true}}}
