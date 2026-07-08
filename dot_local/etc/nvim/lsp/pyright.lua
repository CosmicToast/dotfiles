-- [nfnl] Compiled from lsp/pyright.fnl by https://github.com/Olical/nfnl, do not edit.
return {cmd = {"basedpyright-langserver", "--stdio"}, filetypes = {"python"}, root_markers = vim.lsp.config.ruff.root_markers, settings = {python = {analysis = {diagnosticMode = "openFilesonly"}, logLevel = "Warning"}}}
