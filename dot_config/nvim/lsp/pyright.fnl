{:cmd [:basedpyright-langserver :--stdio]
 :filetypes [:python]
 :root_markers vim.lsp.config.ruff.root_markers
 :settings {:python {:analysis {:diagnosticMode :openFilesonly}
                     :logLevel :Warning}}}
